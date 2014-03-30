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

  def self.alloc
    new(true).alloc
  end

  def self.inherited(parent)
    include ClassMethods
    if parent.name
      klass = ObjC.objc_allocateClassPair(ObjC.objc_getClass(name.split('::').last),parent.name,0)
      ObjC.objc_registerClassPair(klass)
    end
  end

  def initialize allocated=false
    @klass = ObjC.objc_getClass(self.native_name)
    unless allocated
      self.object = @klass
      new
    end
  end

  def get_class
    ObjC.objc_getClass(self.native_name)
  end

  def alloc
    self.object = ObjC.msgSend(ObjC.objc_getClass(self.native_name),"alloc")
    self
  end

  def init
    self.object = ObjC.msgSend(@object,"init")
    self
  end

  def new
    self.object = ObjC.msgSend(@object,"new")
    self
  end

  def autorelease
    self.object = ObjC.msgSend(@object,"autorelease")
    self
  end

  module ClassMethods
    def native_name
      self.class.name.split('::').last
    end
  end
end
