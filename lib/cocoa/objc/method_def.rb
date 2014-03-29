module ObjC
  class MethodDef
    attr_accessor :name,:names,:types,:return_type

    def initialize name,options
      @name = name.to_sym
      @names = options[:names].map(&:to_sym)
      @types = options[:types]
      @return_type = options[:retval]
    end

    def ffi_types
      @ffi_types ||= types.map do |type|
        case type
        when '@'
          :pointer
        when 'q'
          :long_long
        when '^v'
          :pointer
        when /^{([^=]*)=.*}$/
          Cocoa::const_get($1).by_value
        else
          raise type
        end
      end
    end

    def ffi_return_type
      @ffi_return_type ||= case return_type
      when nil
        :void
      when 'v'
        :void
      when '@'
        :pointer
      when 'q'
        :long_long
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
          case types[i]
          when 'q'
            [:long_long,value]
          when 'Q'
            [:ulong_long,value]
          when 'd'
            [:double,value]
          else
            raise types[i].inspect
          end
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

    def selector
      @selector ||= begin
        if types.size > 0
          "#{name}#{(['']+names).join(':')}:"
        else
          name.to_s
        end
      end
    end

    def call this,object,*args
      values = if @types.size == 0
        []
      elsif @types.size == 1
        args
      else
        [args.first] + args.last.values
      end

      # TODO: BUG: cascadeTopLeftFromPoint struggles with msgSend_stret
      if return_type =~ /^{([^=]*)=.*}$/ && name != :cascadeTopLeftFromPoint
        ObjC.msgSend_stret(Cocoa.const_get($1),object,selector,*ffi_casted(values))
      else
# puts args.inspect
# puts values.inspect
# puts ffi_casted(values).inspect
# puts selector
        ret = ObjC.msgSend(object,selector,*ffi_casted(values))
        return if name == :cascadeTopLeftFromPoint
        case return_type
        when '@'
          return nil if ret.address == 0
          return ret if name == :NSStringFromClass
          ObjC.object_to_instance(ret)
        when 'v'
          this
        when '^v'
          ret
        when 'Q', 'q'
          ret.address
        when 'B'
          ret.address ? true : false
        when /^\^{([^=]*)=.*}$/
          ObjC.object_to_instance(ret)
        when '*'
          ret.read_string
        else
          raise return_type
        end
      end
    end
  end
end
