
require 'cocoa/objc/method_def'

module ObjC
  extend FFI::Library
 
  ffi_lib 'objc'
 
  attach_function :sel_registerName, [:string], :pointer
  attach_function :objc_getClass, [:string], :pointer
  attach_function :objc_allocateClassPair, [:pointer, :string, :int], :pointer
  attach_function :objc_registerClassPair, [:pointer], :void

  MethodDef::TYPES.values.uniq.each do |type|
    name = "objc_msgSend_#{type}".to_sym
    attach_function name, :objc_msgSend, [:pointer, :pointer, :varargs], type
    define_singleton_method "msgSend_#{type}".to_sym do |id, selector, *args|
      selector = sel_registerName(selector) if selector.is_a? String
      send(name, id, selector, *args )
    end
  end

  def self.msgSend_stret( return_type, id, selector, *args )
    selector = sel_registerName(selector) if selector.is_a? String
    method = "objc_msgSend_stret_for_#{return_type.name.underscore.gsub('/','_')}".to_sym
    unless respond_to? method
      attach_function method, :objc_msgSend_stret, [:pointer, :pointer, :varargs], return_type.by_value
    end
    send(method, id, selector, *args )
  end

  def self.String_to_NSString( string )
    nsstring_class = objc_getClass("NSString")
    msgSend_pointer(nsstring_class, "stringWithUTF8String:", :string, string )
  end
 
  def self.NSString_to_String( nsstring_pointer )
    c_string = msgSend_pointer( nsstring_pointer, "UTF8String")
    if c_string.null?
      return "(NULL)"
    else
      return c_string.read_string()
    end
  end

  def self.smart_constantize ret,klass_name
    begin
      Cocoa.const_get(klass_name)
    rescue
      _superclass = ObjC.msgSend_pointer(ret,'superclass')
      superclass_name = ObjC::NSString_to_String(Cocoa::NSStringFromClass(_superclass))
      superclass_name = if superclass_name =~ /^__NSCF/
        "NS#{klass_name[6..-1]}" 
      elsif superclass_name[0]=='_'
        if superklass = Cocoa::const_get(NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend_pointer(ret,"superclass"))))
          superklass.name.split('::').last
        else
          "FIX_#{superclass_name}" 
        end
      else
        superclass_name
      end
      superclass = Cocoa::const_get(superclass_name) rescue smart_constantize(_superclass,superclass_name)
      proxy = Class.new(superclass)
      Cocoa.const_set(klass_name, proxy)
      klass = Cocoa.const_get(klass_name)
      superclass.inherited(klass)
      klass
    end
  end

  def self.object_to_instance ret
    klass_name = NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend_pointer(ret,"class")))
    return self if klass_name == '(NULL)'
    instance = begin
      Cocoa::const_get(klass_name).new(true)
    rescue
      klass_name = if klass_name =~ /^__NSCF/
        "NS#{klass_name[6..-1]}" 
      elsif klass_name[0]=='_'
        if superklass = Cocoa::const_get(NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend_pointer(ret,"superclass"))))
          superklass.name.split('::').last
        else
          "FIX_#{klass_name}" 
        end
      else
        klass_name
      end
      klass = smart_constantize(ret,klass_name)
      klass.new(true)
    end
    instance.object = ret
    instance
  end

  def self.ffi_to_ruby_value method,ffi_value,type
    case type
    when '@'
      return nil if ffi_value.address == 0
      return ffi_value if method == :NSStringFromClass
      ObjC.object_to_instance(ffi_value)
    when '^v', 'Q', 'q', 'D', 'd', 'B', 'I', 'i'
      ffi_value
    when /^\^{([^=]*)=.*}$/
      return nil if ffi_value.address == 0
      ObjC.object_to_instance(ffi_value)
    when '*'
      ffi_value.read_string
    when '#'
      ffi_value
    when /^{([^=]*)=.*}$/
      ffi_value
    else
      raise type.inspect
    end
  end

  def self.objc_type type,default='i'
    case type
    when nil
      default
    when '@', 'v', 'q', 'Q', '^v'
      type
    when /^{([^=]*)=.*}$/
      type
    when /^\^{([^=]*)=.*}$/
      type
    else
      raise type.inspect
    end
  end

end
