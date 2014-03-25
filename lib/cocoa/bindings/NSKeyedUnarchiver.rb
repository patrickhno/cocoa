# generated by 'rake generate'
require 'cocoa/bindings/NSCoder'
module Cocoa
  class NSKeyedUnarchiver < Cocoa::NSCoder
    attach_singular_method :classForClassName, :args=>1, :names=>[], :types=>["@"], :retval=>"#"
    attach_method :classForClassName, :args=>1, :names=>[], :types=>["@"], :retval=>"#"
    attach_method :containsValueForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"B"
    attach_method :decodeBoolForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"B"
    attach_method :decodeBytesForKey, :args=>2, :names=>["returnedLength"], :types=>["@", "^Q"], :retval=>"*"
    attach_method :decodeDoubleForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"d"
    attach_method :decodeFloatForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"f"
    attach_method :decodeInt32ForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"i"
    attach_method :decodeInt64ForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"q"
    attach_method :decodeIntForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"i"
    attach_method :decodeObjectForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_method :delegate, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :finishDecoding, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :initForReadingWithData, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_singular_method :setClass, :args=>2, :names=>["forClassName"], :types=>["#", "@"], :retval=>"v"
    attach_method :setClass, :args=>2, :names=>["forClassName"], :types=>["#", "@"], :retval=>"v"
    attach_method :setDelegate, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_singular_method :unarchiveObjectWithData, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_singular_method :unarchiveObjectWithFile, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
  end
end