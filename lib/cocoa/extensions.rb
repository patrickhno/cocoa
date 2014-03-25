class Cocoa::NSString < Cocoa::NSObject
  def to_s
    Cocoa::NSString_to_String(object)
  end
end

class String
  def method_missing meth,*args
    if Cocoa::NSString.method_defined?(meth)
      str = Cocoa::NSString.new(true)
      str.object = Cocoa::String_to_NSString(self)
      str.send(meth,*args)
    else
      super
    end
  end
end
