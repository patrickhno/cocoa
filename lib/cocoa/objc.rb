module ObjC
  extend FFI::Library
 
  ffi_lib 'objc'
 
  attach_function :sel_registerName, [:string], :pointer
  attach_function :objc_msgSend, [:pointer, :pointer, :varargs], :pointer
  attach_function :objc_getClass, [:string], :pointer
  attach_function :objc_allocateClassPair, [:pointer, :string, :int], :pointer
  attach_function :objc_registerClassPair, [:pointer], :void

  def self.msgSend( id, selector, *args )
    selector = sel_registerName(selector) if selector.is_a? String
    objc_msgSend( id, selector, *args )
  end

  def self.msgSend_stret( return_type, id, selector, *args )
    selector = sel_registerName(selector) if selector.is_a? String
    method = "objc_msgSend_stret_for_#{return_type.name.underscore}".to_sym
    unless respond_to? method
      attach_function method, :objc_msgSend_stret, [:pointer, :pointer, :varargs], return_type.by_value
    end
    send(method, id, selector, *args )
  end

  def self.String_to_NSString( string )
    nsstring_class = objc_getClass("NSString")
    msgSend(nsstring_class, "stringWithUTF8String:", :string, string )
  end
 
  def self.NSString_to_String( nsstring_pointer )
    c_string = msgSend( nsstring_pointer, "UTF8String")
    if c_string.null?
      return "(NULL)"
    else
      return c_string.read_string()
    end
  end

  def self.translate_retval method,ret,type
    case type
    when '@'
      return nil if ret.address == 0
      return ret if method == :NSStringFromClass
      klass_name = NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend(ret,"class")))
      return self if klass_name == '(NULL)'
      instance = begin
        ("Cocoa::"+klass_name).constantize.new(true)
      rescue
        klass_name = if klass_name =~ /^__NSCF/
          "NS#{klass_name[6..-1]}" 
        elsif klass_name[0]=='_'
          "FIX_#{klass_name}" 
        else
          klass_name
        end
        klass = begin
          Cocoa.const_get(klass_name)
        rescue => e
          superclass_name = NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend(ret,'superclass')))
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
    when '#'
      ret
    when /^{([^=]*)=.*}$/
      ret
    when /^\^{[^=]*=.*}$/
      return nil if ret.address == 0
      klass_name = NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend(ret,"class")))
      return self if klass_name == '(NULL)'
      instance = begin
        ("Cocoa::"+klass_name).constantize.new(true)
      rescue
        klass_name = "FIX_#{klass_name}" if klass_name[0]=='_'
        klass = begin
          Cocoa.const_get(klass_name)
        rescue => e
          superclass_name = NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend(ret,'superclass')))
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
    else
      raise type
    end
  end

  def self.fixed_args args,params={},types=[],options={}
    if options[:variadic]
      _types = (types.dup*args.size)
      args
    else
      _types = types.dup
      ([args.first]+params.values)
    end.map do |arg|
      type = _types.shift
      case arg
      when TrueClass, FalseClass
        [:bool,arg]
      when Fixnum, Bignum
        case type
        when 'q'
          [:long_long,arg]
        when 'Q'
          [:ulong_long,arg]
        when 'd'
          [:double,arg]
        else
          raise type.inspect
        end
      when Float
        [:double,arg]
      when String
        [:pointer,ObjC.String_to_NSString(arg)]
      when NilClass
        [:pointer,nil]
      when Symbol
        [:pointer,ObjC.sel_registerName("#{arg}:")]
      when Cocoa::NSObject
        [:pointer,arg.object]
      when FFI::Struct
        [arg.class.by_value,arg]
      when FFI::Pointer
        [:pointer,arg]
      else
        raise ArgumentError.new("#{arg.class.name}: #{arg.inspect}")
      end
    end.flatten
  end

  def self.apple_type_to_ffi type
    # TODO: These are just stubbed on guess - check'em'all
    case type
    when 'C'
      :uchar
    when '@'
      :pointer
    when '#'
      :pointer
    when 'Q'
      :int
    when ':'
      :pointer
    when 'I'
      :int
    when 'L'
      :int
    when 'd'
      :double
    when 'f'
      :float
    when 'i'
      :int
    when 's'
      :int
    when 'q'
      :long_long
    when 'S'
      :int
    when /^\^/
      :pointer
    when 'B'
      :bool
    when 'v'
      :void
    when '[5*]'
      :void
    when /^{[^=]*=.*}$/
      begin
        /^{_*([^=]*)=.*}$/.match(type)[1].constantize.by_value
      rescue => e
        begin
          "Cocoa::#{/^{_*([^=]*)=.*}$/.match(type)[1]}".constantize.by_value
        rescue => e
          match = /^{_*([^=]*)=(.*)}$/.match(type)
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
    when '*' # character string
      :pointer
    when '@?'
      :pointer
    else
      raise type.inspect
    end
  end

  def self.objc_type type,default='i'
    case type
    when nil
      default
    when '@'
      type
    when 'v'
      type
    when /^{([^=]*)=.*}$/
      type
    else
      raise type.inspect
    end
  end
end
