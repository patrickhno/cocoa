# generated by 'rake generate'
require 'cocoa/bindings/NSPredicate'
module Cocoa
  class NSComparisonPredicate < Cocoa::NSPredicate
    attach_method :comparisonPredicateModifier, :args=>0, :names=>[], :types=>[], :retval=>"Q"
    attach_method :customSelector, :args=>0, :names=>[], :types=>[], :retval=>":"
    attach_method :initWithLeftExpression, [{:args=>3, :names=>["rightExpression", "customSelector"], :types=>["@", "@", ":"], :retval=>"@"}, {:args=>5, :names=>["rightExpression", "modifier", "type", "options"], :types=>["@", "@", "Q", "Q", "Q"], :retval=>"@"}]
    attach_method :leftExpression, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :options, :args=>0, :names=>[], :types=>[], :retval=>"Q"
    attach_method :predicateOperatorType, :args=>0, :names=>[], :types=>[], :retval=>"Q"
    attach_singular_method :predicateWithLeftExpression, [{:args=>3, :names=>["rightExpression", "customSelector"], :types=>["@", "@", ":"], :retval=>"@"}, {:args=>5, :names=>["rightExpression", "modifier", "type", "options"], :types=>["@", "@", "Q", "Q", "Q"], :retval=>"@"}]
    attach_method :rightExpression, :args=>0, :names=>[], :types=>[], :retval=>"@"
  end
end