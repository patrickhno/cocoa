# generated by 'rake generate'
require 'cocoa/bindings/NSPort'
module Cocoa
  class NSMachPort < Cocoa::NSPort
    attach_method :delegate, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :initWithMachPort, [{:args=>1, :names=>[], :types=>["I"], :retval=>"@"}, {:args=>2, :names=>["options"], :types=>["I", "Q"], :retval=>"@"}]
    attach_method :machPort, :args=>0, :names=>[], :types=>[], :retval=>"I"
    attach_singular_method :portWithMachPort, [{:args=>1, :names=>[], :types=>["I"], :retval=>"@"}, {:args=>2, :names=>["options"], :types=>["I", "Q"], :retval=>"@"}]
    attach_method :removeFromRunLoop, :args=>2, :names=>["forMode"], :types=>["@", "@"], :retval=>"v"
    attach_method :scheduleInRunLoop, :args=>2, :names=>["forMode"], :types=>["@", "@"], :retval=>"v"
    attach_method :setDelegate, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
  end
end