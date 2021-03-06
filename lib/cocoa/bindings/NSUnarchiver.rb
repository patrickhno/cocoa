# generated by 'rake generate'
require 'cocoa/bindings/NSCoder'
module Cocoa
  class NSUnarchiver < Cocoa::NSCoder
    attach_singular_method :classNameDecodedForArchiveClassName, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_method :classNameDecodedForArchiveClassName, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_singular_method :decodeClassName, :args=>2, :names=>[:asClassName], :types=>["@", "@"], :retval=>"v"
    attach_method :decodeClassName, :args=>2, :names=>[:asClassName], :types=>["@", "@"], :retval=>"v"
    attach_method :initForReadingWithData, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_method :isAtEnd, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :objectZone, :args=>0, :names=>[], :types=>[], :retval=>"^{_NSZone=}"
    attach_method :replaceObject, :args=>2, :names=>[:withObject], :types=>["@", "@"], :retval=>"v"
    attach_method :setObjectZone, :args=>1, :names=>[], :types=>["^{_NSZone=}"], :retval=>"v"
    attach_method :systemVersion, :args=>0, :names=>[], :types=>[], :retval=>"I"
    attach_singular_method :unarchiveObjectWithData, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_singular_method :unarchiveObjectWithFile, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
  end
end
