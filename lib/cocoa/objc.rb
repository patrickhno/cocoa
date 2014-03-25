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
end
