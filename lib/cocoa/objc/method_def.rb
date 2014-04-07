module ObjC
  class MethodDef
    attr_accessor :name,:names,:types,:return_type

    TYPES = {
      'c' => :char,
      'i' => :int,
      's' => :short,
      'l' => :long,
      'q' => :long_long,
      'C' => :uchar,
      'I' => :uint,
      'S' => :ushort,
      'L' => :ulong,
      'Q' => :ulong_long,
      'f' => :float,
      'd' => :double,
      'B' => :bool,
      'v' => :void,
      '*' => :pointer, # :string?
      '@' => :pointer,
      '#' => :pointer,
      ':' => :pointer,
      # [array type]   - An array
      # {name=type...} - A structure
      # (name=type...) - A union
      # bnum           - A bit field of num bits
      # ^type          - A pointer to type
      # ?              - An unknown type (among other things, this code is used for function pointers)
    }

    def initialize name,options
      @name = name.to_sym
      @names = options[:names].map(&:to_sym)
      @types = options[:types]
      @return_type = options[:retval]
      @variadic = options[:variadic]
    end

    def variadic?
      @variadic
    end

    def ffi_types
      @ffi_types ||= types.map do |type|
        TYPES[type] || case type
        when '@?'
          :pointer
        when '^v', /^\^/, '^?', '^I'
          :pointer
        when /^{([^=]*)=(.*)}$/
          begin
            Cocoa::const_get($1).by_value
          rescue
            # this stuff doesnt work with jruby
            attribs = $2
            klass_name = /^{_*([^=]*)=.*}$/.match(type)[1]
            klass = begin
              Cocoa.const_get(klass_name)
            rescue
              klass = Class.new(FFI::Struct)
              Cocoa.const_set($1, klass)
              name = 'a'
              layout = []
              attribs.each_char do |c|
                layout << name.to_sym
                name = name.next
                layout << case c
                when '^', '?'
                  :pointer
                when 'v'
                  :pointer
                else
                  TYPES[c]
                end
              end
              klass = Cocoa::const_get($1)
              klass.layout *layout
              klass
            end
            klass.by_ref
          end
        when /^\^{([^=]*)=.*}$/
          :pointer
        else
          raise type.inspect
        end
      end
    end

    def ffi_return_type
      @ffi_return_type ||= TYPES[return_type] || case return_type
      when nil
        :void
      when 'v'
        :void
      when /^\^/
        :pointer
      when '[5*]'
        :void
      when /^{[^=]*=.*}$/
        begin
          /^{_*([^=]*)=.*}$/.match(return_type)[1].constantize.by_value
        rescue => e
          begin
            "Cocoa::#{/^{_*([^=]*)=.*}$/.match(return_type)[1]}".constantize.by_value
          rescue => e
            match = /^{_*([^=]*)=(.*)}$/.match(return_type)
            klass = begin
              Cocoa.const_get(match[1])
            rescue
              # puts "defining struct Cocoa::#{match[1]} as #{match[2]}"
              # this stuff doesnt work with jruby
              klass = Class.new(FFI::Struct)
              Cocoa.const_set(match[1], klass)
              name = 'a'
              layout = []
              match[2].each_char do |c|
                case c
                when 'd'
                  layout << name.to_sym
                  name = name.next
                  layout << :double
                end
              end
              klass = "Cocoa::#{match[1]}".constantize
              klass.layout *layout
              klass
            end
            klass.by_ref
          end
        end
      when nil
        :void
      when '@?'
        :pointer
      else
        raise self.inspect
      end
    end

    def objc_types
      ObjC.objc_type(@return_value,'v')+'@:'+@types.map{ |type| ObjC.objc_type(type) }.join
    end

    def ffi_casted values
      i = -1
      values.map do |value|
        i += 1
        case value
        when TrueClass, FalseClass
          [:bool,value]
        when Fixnum, Bignum
          [TYPES[types[i]],value]
        when Float
          [:double,value]
        when String
          [:pointer,ObjC.String_to_NSString(value)]
        when NilClass
          [:pointer,nil]
        when Symbol
          [:pointer,ObjC.sel_registerName("#{value}:")]
        when Cocoa::NSObject
          [:pointer,value.object]
        when FFI::Struct
          [value.class.by_value,value]
        when FFI::Pointer
          [:pointer,value]
        else
          raise ArgumentError.new(value.inspect)
        end
      end.flatten
    end

    def call_arguments args
      fixed_args = []
      args.each_with_index do |arg,i|
        case types[i]
        when '@'
          fixed_args << arg
        when 'd'
          if arg.is_a?(Fixnum)
            fixed_args << arg.to_f
          else
            raise ArgumentError.new("float expected, got #{arg.class.name}") unless arg.is_a?(Float)
            fixed_args << arg
          end
        when 'I'
          raise ArgumentError unless arg.is_a?(Fixnum)
          fixed_args << arg
        when 'Q', 'q'
          raise ArgumentError.new(arg.inspect) unless arg.is_a?(Fixnum)
          fixed_args << arg
        when '#'
          raise ArgumentError unless arg.is_a?(FFI::Pointer)
          fixed_args << arg
        when /^{[^=]*=.*}$/
          raise ArgumentError.new(arg.inspect) unless arg.kind_of?(FFI::Struct)
          fixed_args << arg
        when /^\^{([^=]*)=.*}$/
          case arg
          when FFI::Pointer
            fixed_args << arg
          when Array
            raise ArgumentError unless $1 == '__CFArray'
            fixed_args << NSArray.arrayWithObjects(arg).object
          else
            match = $1
            if arg.class.name =~ /^Cocoa::/ # "Cocoa::#{$1}".constantize
              fixed_args << arg.object
            elsif arg.is_a?(NilClass)
              fixed_args << FFI::MemoryPointer::NULL
            elsif arg.is_a?(String) && match == '__CFString'
              fixed_args << Cocoa::String_to_NSString(arg)
            else
              raise ArgumentError.new("expected #{params[:types][i]} got #{arg.class.name} (#{match})")
            end
          end
        when '^d'
          raise ArgumentError unless arg.is_a?(Array)
          arr = FFI::MemoryPointer.new(:double,arg.size)
          arr.write_array_of_double(arg)
          fixed_args << arr
        when '^v'
          raise ArgumentError unless arg.is_a?(NilClass)
          fixed_args << FFI::MemoryPointer::NULL
        else
          raise types[i]
        end
      end
      fixed_args
    end

    def selector
      @selector ||= begin
        if types.size > 0
          "#{name}#{(['']+names).join(':')}:"
        else
          name.to_s
        end
      end
    end

    def ruby_return_value this,ffi_value
      case return_type
      when 'v'
        this
      else
        ObjC.ffi_to_ruby_value name,ffi_value,return_type
      end
    end

    def call this, object, *args
      values = if @types.size == 0
        []
      elsif @types.size == 1
        args
      else
        [args.first] + args.last.values
      end

      # TODO: BUG: cascadeTopLeftFromPoint struggles with msgSend_stret
      if return_type =~ /^{([^=]*)=.*}$/ && name != :cascadeTopLeftFromPoint
        struct = Cocoa.const_get($1.sub(/^_NS/,'NS'))
        ObjC.msgSend_stret(struct,object,selector,*ffi_casted(values))
      else
        ret = ObjC.msgSend(object,selector,*ffi_casted(values))
        return if name == :cascadeTopLeftFromPoint
        return ret if name == :NSStringFromClass
        ruby_return_value(this,ret)
      end
    end

    def callback instance, params, args
      keys = params.select{ |param| param.first == :key }.map{ |param| param.last }

      ret = if params.size > 0 && params.last.first == :rest
        args = args.map{ |arg| Cocoa::instance_for(arg) }
        instance.send(name, args.first, Hash[*names.zip(args[1..-1]).flatten])
      elsif keys.size > 0
        args = args.map{ |arg| Cocoa::instance_for(arg) }
        instance.send(name, args.first, Hash[*keys.zip(args[1..-1]).flatten])
      else
        instance.send(name, *args.map{ |arg| Cocoa::instance_for(arg) })
      end
      ffi_return_value(ret)
    end

    def ffi_return_value value
      case return_type
      when '@'
        case value
        when NilClass
          nil
        when String
          Cocoa::NSString.stringWithString(value).object
        else
          raise value.inspect
        end
      when 'q', 'Q', 'd'
        value
      when 'v'
        nil
      else
        raise inspect
      end
    end

  end
end
