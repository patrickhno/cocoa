# generated by 'rake generate'
require 'cocoa/bindings/NSPortNameServer'
module Cocoa
  class NSMachBootstrapServer < Cocoa::NSPortNameServer
    attach_method :portForName, [{:args=>1, :names=>[], :types=>["@"], :retval=>"@"}, {:args=>2, :names=>[:host], :types=>["@", "@"], :retval=>"@"}]
    attach_method :registerPort, :args=>2, :names=>[:name], :types=>["@", "@"], :retval=>"B"
    attach_method :servicePortWithName, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_singular_method :sharedInstance, :args=>0, :names=>[], :types=>[], :retval=>"@"
  end
end
