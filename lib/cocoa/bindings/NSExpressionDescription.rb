# generated by 'rake generate'
require 'cocoa/bindings/NSPropertyDescription'
module Cocoa
  class NSExpressionDescription < Cocoa::NSPropertyDescription
    attach_method :expression, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :expressionResultType, :args=>0, :names=>[], :types=>[], :retval=>"Q"
    attach_method :setExpression, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setExpressionResultType, :args=>1, :names=>[], :types=>["Q"], :retval=>"v"
  end
end
