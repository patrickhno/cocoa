# generated by 'rake generate'
require 'cocoa/bindings/NSObject'
module Cocoa
  class NSCoder < Cocoa::NSObject
    attach_method :allowedClasses, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :allowsKeyedCoding, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :containsValueForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"B"
    attach_method :decodeArrayOfObjCType, :args=>3, :names=>[:count, :at], :types=>["*", "Q", "^v"], :retval=>"v"
    attach_method :decodeBoolForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"B"
    attach_method :decodeBytesForKey, :args=>2, :names=>[:returnedLength], :types=>["@", "^Q"], :retval=>"*"
    attach_method :decodeBytesWithReturnedLength, :args=>1, :names=>[], :types=>["^Q"], :retval=>"^v"
    attach_method :decodeDataObject, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :decodeDoubleForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"d"
    attach_method :decodeFloatForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"f"
    attach_method :decodeInt32ForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"i"
    attach_method :decodeInt64ForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"q"
    attach_method :decodeIntForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"i"
    attach_method :decodeIntegerForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"q"
    attach_method :decodeNXColor, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :decodeNXObject, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :decodeObject, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :decodeObjectForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_method :decodeObjectOfClass, :args=>2, :names=>[:forKey], :types=>["#", "@"], :retval=>"@"
    attach_method :decodeObjectOfClasses, :args=>2, :names=>[:forKey], :types=>["@", "@"], :retval=>"@"
    attach_method :decodePoint, :args=>0, :names=>[], :types=>[], :retval=>"{CGPoint=dd}"
    attach_method :decodePointForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"{CGPoint=dd}"
    attach_method :decodePropertyList, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :decodePropertyListForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_method :decodeRect, :args=>0, :names=>[], :types=>[], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :decodeRectForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :decodeSize, :args=>0, :names=>[], :types=>[], :retval=>"{CGSize=dd}"
    attach_method :decodeSizeForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"{CGSize=dd}"
    attach_method :decodeValueOfObjCType, :args=>2, :names=>[:at], :types=>["*", "^v"], :retval=>"v"
    attach_method :decodeValuesOfObjCTypes, :args=>1, :names=>[], :types=>["*"], :retval=>"v", :variadic=>true
    attach_method :encodeArrayOfObjCType, :args=>3, :names=>[:count, :at], :types=>["*", "Q", "^v"], :retval=>"v"
    attach_method :encodeBool, :args=>2, :names=>[:forKey], :types=>["B", "@"], :retval=>"v"
    attach_method :encodeBycopyObject, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :encodeByrefObject, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :encodeBytes, [{:args=>2, :names=>[:length], :types=>["^v", "Q"], :retval=>"v"}, {:args=>3, :names=>[:length, :forKey], :types=>["*", "Q", "@"], :retval=>"v"}]
    attach_method :encodeConditionalObject, [{:args=>1, :names=>[], :types=>["@"], :retval=>"v"}, {:args=>2, :names=>[:forKey], :types=>["@", "@"], :retval=>"v"}]
    attach_method :encodeDataObject, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :encodeDouble, :args=>2, :names=>[:forKey], :types=>["d", "@"], :retval=>"v"
    attach_method :encodeFloat, :args=>2, :names=>[:forKey], :types=>["f", "@"], :retval=>"v"
    attach_method :encodeInt32, :args=>2, :names=>[:forKey], :types=>["i", "@"], :retval=>"v"
    attach_method :encodeInt64, :args=>2, :names=>[:forKey], :types=>["q", "@"], :retval=>"v"
    attach_method :encodeInt, :args=>2, :names=>[:forKey], :types=>["i", "@"], :retval=>"v"
    attach_method :encodeInteger, :args=>2, :names=>[:forKey], :types=>["q", "@"], :retval=>"v"
    attach_method :encodeNXObject, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :encodeObject, [{:args=>1, :names=>[], :types=>["@"], :retval=>"v"}, {:args=>2, :names=>[:forKey], :types=>["@", "@"], :retval=>"v"}]
    attach_method :encodePoint, [{:args=>1, :names=>[], :types=>["{CGPoint=dd}"], :retval=>"v"}, {:args=>2, :names=>[:forKey], :types=>["{CGPoint=dd}", "@"], :retval=>"v"}]
    attach_method :encodePropertyList, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :encodeRect, [{:args=>1, :names=>[], :types=>["{CGRect={CGPoint=dd}{CGSize=dd}}"], :retval=>"v"}, {:args=>2, :names=>[:forKey], :types=>["{CGRect={CGPoint=dd}{CGSize=dd}}", "@"], :retval=>"v"}]
    attach_method :encodeRootObject, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :encodeSize, [{:args=>1, :names=>[], :types=>["{CGSize=dd}"], :retval=>"v"}, {:args=>2, :names=>[:forKey], :types=>["{CGSize=dd}", "@"], :retval=>"v"}]
    attach_method :encodeValueOfObjCType, :args=>2, :names=>[:at], :types=>["*", "^v"], :retval=>"v"
    attach_method :encodeValuesOfObjCTypes, :args=>1, :names=>[], :types=>["*"], :retval=>"v", :variadic=>true
    attach_method :objectZone, :args=>0, :names=>[], :types=>[], :retval=>"^{_NSZone=}"
    attach_method :requiresSecureCoding, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :setObjectZone, :args=>1, :names=>[], :types=>["^{_NSZone=}"], :retval=>"v"
    attach_method :systemVersion, :args=>0, :names=>[], :types=>[], :retval=>"I"
    attach_method :versionForClassName, :args=>1, :names=>[], :types=>["@"], :retval=>"q"
  end
end
