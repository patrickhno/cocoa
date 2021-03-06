# generated by 'rake generate'
require 'cocoa/bindings/NSObject'
module Cocoa
  class CAConstraint < Cocoa::NSObject
    attach_method :attribute, :args=>0, :names=>[], :types=>[], :retval=>"i"
    attach_singular_method :constraintWithAttribute, [{:args=>3, :names=>[:relativeTo, :attribute], :types=>["i", "@", "i"], :retval=>"@"}, {:args=>4, :names=>[:relativeTo, :attribute, :offset], :types=>["i", "@", "i", "d"], :retval=>"@"}, {:args=>5, :names=>[:relativeTo, :attribute, :scale, :offset], :types=>["i", "@", "i", "d", "d"], :retval=>"@"}]
    attach_method :initWithAttribute, :args=>5, :names=>[:relativeTo, :attribute, :scale, :offset], :types=>["i", "@", "i", "d", "d"], :retval=>"@"
    attach_method :offset, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :scale, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :sourceAttribute, :args=>0, :names=>[], :types=>[], :retval=>"i"
    attach_method :sourceName, :args=>0, :names=>[], :types=>[], :retval=>"@"
  end
end
