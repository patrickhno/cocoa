class Cocoa::NSString < Cocoa::NSObject
  def to_s
    ObjC.NSString_to_String(object)
  end
  def == other
    to_s == other.to_s
  end
end

class String
  def method_missing meth,*args
    if Cocoa::NSString.method_defined?(meth)
      str = Cocoa::NSString.new(true)
      str.object = ObjC.String_to_NSString(self)
      str.send(meth,*args)
    else
      super
    end
  end
end

class Cocoa::NSObject

  def self.const_missing name
    Cocoa.const_get name
  end

  def self.native_name
    arr = name.split('::')
    native = if arr.first == 'Cocoa'
      arr.last
    else
      name.gsub(/::/,'__')
    end
    native
  end

  def self.alloc
    instance = new(true)
    instance.object = ObjC.msgSend_pointer(get_class,"alloc")
    instance
  end

  def self.inherited(parent)
    if parent.name
      klass = begin
        Cocoa::const_get(parent.native_name)
        ObjC.objc_getClass(parent.native_name)
      rescue
      end
      unless klass && klass.address != 0
        klass = ObjC.objc_allocateClassPair(ObjC.objc_getClass(native_name),parent.native_name,0)
        ObjC.objc_registerClassPair(klass)
      end
    end
  end

  def self.get_class
    ObjC.objc_getClass(native_name)
  end

  def initialize allocated=false
    @klass = ObjC.objc_getClass(self.class.native_name)
    unless allocated
      self.object = @klass
      new
    end
  end

  def init
    self.object = ObjC.msgSend_pointer(@object,"init")
    self
  end

  def new
    self.object = ObjC.msgSend_pointer(@object,"new")
    self
  end

  def autorelease
    self.object = ObjC.msgSend_pointer(@object,"autorelease")
    self
  end
end
