class Cocoa::NSString < Cocoa::NSObject
  def to_s
    Cocoa::NSString_to_String(object)
  end
end
