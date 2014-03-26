require 'active_support/inflector'
require 'ffi'
require 'cocoa/objc'

module Cocoa; end

require 'cocoa/structs/NSPoint'
require 'cocoa/structs/NSSize'
require 'cocoa/structs/NSRect'
require 'cocoa/structs/NSRange'

module Cocoa

  def instances
    @@instances ||= {}
  end
  def instance_for data
    if data.is_a?(FFI::Pointer)
      @@instances[data.address] ||= ObjC.translate_retval nil,data,'@'
    else
      data
    end
  end

  def self.attach_nsstring_getter method
    raw = "get_objc_#{method}".to_sym
    attach_variable raw, method, :pointer
    if /[A-Z]/ =~ method.to_s[0]
      Cocoa.const_set(method,ObjC.NSString_to_String(send(raw)))
    else
      define_singleton_method method do
       ObjC.NSString_to_String(send(raw))
      end
    end
  end

  def self.attach_singular_method method,*params
    params = params.extract_options!
    params.freeze
    if params[:args] == 0
      define_singleton_method method do
        instance = new(true)
        instance.object = ObjC.msgSend(instance.klass,method.to_s)
        instance
      end
    else
      define_singleton_method method do |*args|
        raise "hell"
      end
    end
  end

  def self.attach_method method,*params
    if params.first.is_a? Array
      params = params.last
    end

    params = params.extract_options!
    params.freeze
    if params[:args] == 0
      begin
        attach_function "call_#{method}".to_sym, method, [], ObjC.apple_type_to_ffi(params[:retval])
        define_method method do
          case params[:retval]
          when /^\^{[^=]*=.*}$/
            Cocoa::translate_retval(method,send("call_#{method}".to_sym),params[:retval])
          else
            raise params.inspect
          end
        end
      rescue FFI::NotFoundError => e
        puts "method missing: #{e.message}"
      end
    else
      begin
        attach_function "call_#{method}".to_sym, method, params[:types].map{ |arg| ObjC.apple_type_to_ffi(arg) }, ObjC.apple_type_to_ffi(params[:retval])
        define_method method do |*args|
          raise ArgumentError.new("#{method} requires #{params[:args]} argument(s)") unless params[:args] == args.size
          fixed_args = []
          args.each_with_index do |arg,i|
            case params[:types][i]
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
            when 'Q'
              raise ArgumentError.new(arg.inspect) unless arg.is_a?(Fixnum)
              fixed_args << arg
            when 'q'
              raise ArgumentError unless arg.is_a?(Fixnum)
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
              raise params[:types][i]
            end
          end
          ret = send("call_#{method}".to_sym,*fixed_args)
          if params[:retval]=='v'
            self
          else
            ObjC.translate_retval(method,ret,params[:retval])
          end
        end
      rescue FFI::NotFoundError => e
#        puts "!!!"
#        puts e.message
      end
    end
  end
  extend self

  class NSObject
    attr_accessor :klass
    attr_reader :object

    def self.smart_constantize ret,klass_name
      begin
        Cocoa.const_get(klass_name)
      rescue
        _superclass = ObjC.msgSend(ret,'superclass')
        superclass_name = Cocoa::NSString_to_String(Cocoa::NSStringFromClass(_superclass))
        superclass = begin
          "Cocoa::#{superclass_name}".constantize        
        rescue Exception => e
          smart_constantize(_superclass,superclass_name)
        end
        proxy = Class.new(superclass)
        Cocoa.const_set(klass_name, proxy)
        klass = ("Cocoa::"+klass_name).constantize
        superclass.inherited(klass)
        klass
      end
    end

    def self.attach_singular_method method,*__params
      __params.freeze
      return if method==:class
      return if method==:new
      if __params.first.is_a?(Hash) && __params.first[:args] == 0
        define_singleton_method method do
          instance = new(true)
          instance.object = ObjC.msgSend(instance.klass,method.to_s)
          instance
        end
      else
        _params = [__params.dup].flatten
        _params.freeze
        define_singleton_method method do |*args|
          par = if _params.size == 1 && _params.first[:variadic]
            _params
          else
            _params.select{ |par| (par[:args] == 1 && args.size == 1) || (par[:args] == args.last.size+1 && par[:names].map(&:to_sym).sort == args.last.keys.sort) }
          end
          raise ArgumentError unless par.size == 1
          params = par.dup.extract_options!

          options = args.extract_options!
          fixed_args = if params[:variadic]
            raise "not yet supported" unless params[:types].size == 1
            NSObject.fixed_args(args,options,params[:types],params)
          else
            NSObject.fixed_args(args,options,params[:types])
          end
          ret = ObjC.msgSend(ObjC.objc_getClass(name.split('::').last),"#{method}#{(['']+params[:names]).join(':')}:",*fixed_args)
          case params[:retval]
          when '@'
            return nil if ret.address == 0
            klass_name = Cocoa::NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend(ret,"class")))
            return self if klass_name == '(NULL)'
            instance = begin
              ("Cocoa::"+klass_name).constantize.new(true)
            rescue
              klass_name = klass_name.gsub(/^_*/,'') if klass_name[0]=='_'
              klass = smart_constantize(ret,klass_name)
              klass.new(true)
            end
            instance.object = ret
            instance
          when 'v'
            self
         else
            raise params[:retval]
          end
        end
      end
    end

    def self.attach_method method,*_params
      return if method==:class
      @@method_specs ||= {}
      if _params.first.is_a? Array
        _params = [_params].flatten
        _params.freeze
        define_method method do |*args|
          if args.last.is_a? Hash
            params = _params.select{ |par| par[:args] == args.last.size+1 && par[:names].map(&:to_sym).sort == args.last.keys.sort }
            raise ArgumentError unless params.size == 1
            params = params.extract_options!
            @@method_specs[method] = params

            options = args.extract_options!
            fixed_args = ObjC.fixed_args(args,options,params[:types])
            # puts "ObjC.msgSend(@object,\"#{method}:#{params[:names].join(':')}:\",#{fixed_args.inspect})"
            ObjC.msgSend(@object,"#{method}#{(['']+params[:names]).join(':')}:",*fixed_args)
            self
          else
            params = _params.select{ |par| par[:args] == 1 }
            raise ArgumentError unless params.size == 1
            @@method_specs[method] = params

            fixed_args = ObjC.fixed_args(args)
            # puts "ObjC.msgSend(#{@object.inspect},#{method},#{fixed_args.inspect})"
            ObjC.msgSend(@object,"#{method}:",*fixed_args)
            self
          end
        end
      else
        params = _params.extract_options!
        @@method_specs[method] = params
        if params[:args] == 0
          params.freeze
          define_method method do
            case params[:retval]
            when '@'
              ObjC.translate_retval(method,ObjC.msgSend(@object,method.to_s),params[:retval])
            when 'v'
              ObjC.msgSend(@object,method.to_s)
              self
            when '^v'
              ObjC.msgSend(@object,method.to_s)
            when 'Q'
              ObjC.msgSend(@object,method.to_s).address
            when 'B'
              ret = ObjC.msgSend(@object,method.to_s)
              ret.address ? true : false
            when /^{([^=]*)=.*}$/
              ObjC.msgSend_stret($1.constantize,@object,method.to_s)
            when /^\^{([^=]*)=.*}$/
              ret = ObjC.msgSend(@object,method.to_s)
              klass_name = ObjC.NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend(ret,"class")))
              if klass_name == '__NSCFType'
                # dont know what the hell this is, experiment:
                klass_name = $1
              end
              instance = begin
                ("Cocoa::"+klass_name).constantize.new(true)
              rescue
                klass_name = "FIX_#{klass_name}" if klass_name[0]=='_'
                klass = begin
                  Cocoa.const_get(klass_name)
                rescue => e
                  superclass_name = ObjC.NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend(ret,'superclass')))
                  superclass = "Cocoa::#{superclass_name}".constantize
                  proxy = Class.new(superclass)
                  Cocoa.const_set(klass_name, proxy)
                  klass = ("Cocoa::"+klass_name).constantize
                  superclass.inherited(klass)
                  klass
                end
                klass.new(true)
              end
              instance.object = ret
              instance
            when '*'
              ObjC.msgSend(@object,method.to_s).read_string
            else
              puts params.inspect
              raise params[:retval]
            end
          end
        else
          define_method method do |*args|
            options = args.extract_options!
            fixed_args = ObjC.fixed_args(args,options,params[:types])
            case params[:retval]
            when '@'
              ObjC.translate_retval(method,ObjC.msgSend(@object,"#{method}#{(['']+params[:names]).join(':')}:",*fixed_args),params[:retval])
            else
              ObjC.msgSend(@object,"#{method}#{(['']+params[:names]).join(':')}:",*fixed_args)
              self
            end
          end
        end
      end
    end

    def object= obj
      Cocoa::instances[obj.address] = self
      @object = obj
    end

    def self.ffi_argument_types method
      return [:pointer] unless @@method_specs[method] # own method probably TODO: return argument count * pointers
      @@method_specs[method][:types].map do |type|
        case type
        when '@'
          :pointer
        when /^{([^=]*)=.*}$/
          Cocoa::const_get($1).by_value
        else
          raise type
        end
      end
    end

    def self.ffi_return_type method
      return :void unless @@method_specs[method] # own method probably
      case @@method_specs[method][:retval]
      when nil
        :void
      when 'v'
        :void
      when '@'
        :pointer
      else
        raise @@method_specs[method][:retval].inspect
      end
    end

    def self.objc_argument_types method
      #"@:^{CGRect={CGPoint=dd}{CGSize=dd}}@"
      return 'v@:@' unless @@method_specs[method] # own method probably TODO: @v: + @ times argument count
      ObjC.objc_type(@@method_specs[method][:retval],'v')+'@:'+@@method_specs[method][:types].map{ |type| ObjC.objc_type(type) }.join
    end

    def self.method_added(name)
      return if caller.first.split('`').last[0..-2] == 'define_method'  # MRI
      return if caller.first.split('`').last[0..-2] == 'attach_method'  # Rubinius
      method_definition = "#{self.name.gsub('::','__')}_#{name}".to_sym
      add_method = "add_#{method_definition}".to_sym

      @method_callers ||= {}
      raise "allready added" if @method_callers[method_definition]
      @method_callers[method_definition] = Proc.new do |this,cmd,*args|
        begin
          instance = Cocoa.instances[this.address]
          instance.send(name,*args.map{ |arg| Cocoa::instance_for(arg) })
        rescue => e
          puts e.message
          puts e.backtrace
        end
      end

      ObjC.callback method_definition, [:pointer, :pointer]+ffi_argument_types(name), ffi_return_type(name)
      ObjC.attach_function add_method, :class_addMethod, [:pointer,:pointer,method_definition,:string], :void

      ObjC.send(add_method,ObjC.objc_getClass(self.name.split('::').last),ObjC.sel_registerName("#{name}:"),@method_callers[method_definition],objc_argument_types(name))
    end
  end
end
