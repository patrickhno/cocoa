# generated by 'rake generate'
require 'cocoa/bindings/NSObject'
module Cocoa
  class NSNibConnector < Cocoa::NSObject
    attach_method :destination, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :establishConnection, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :label, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :replaceObject, :args=>2, :names=>["withObject"], :types=>["@", "@"], :retval=>"v"
    attach_method :setDestination, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setLabel, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setSource, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :source, :args=>0, :names=>[], :types=>[], :retval=>"@"
  end
end