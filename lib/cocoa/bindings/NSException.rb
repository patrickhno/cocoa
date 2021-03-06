# generated by 'rake generate'
require 'cocoa/bindings/NSObject'
module Cocoa
  class NSException < Cocoa::NSObject
    attach_method :callStackReturnAddresses, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :callStackSymbols, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_singular_method :exceptionWithName, :args=>3, :names=>[:reason, :userInfo], :types=>["@", "@", "@"], :retval=>"@"
    attach_method :initWithName, :args=>3, :names=>[:reason, :userInfo], :types=>["@", "@", "@"], :retval=>"@"
    attach_method :name, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :raise, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_singular_method :raise, [{:args=>2, :names=>[:format], :types=>["@", "@"], :retval=>"v", :variadic=>true}, {:args=>3, :names=>[:format, :arguments], :types=>["@", "@", "^{__va_list_tag=II^v^v}"], :retval=>"v"}]
    attach_method :reason, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :userInfo, :args=>0, :names=>[], :types=>[], :retval=>"@"
  end
end
