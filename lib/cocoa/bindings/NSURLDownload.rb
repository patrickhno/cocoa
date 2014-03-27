# generated by 'rake generate'
require 'cocoa/bindings/NSObject'
module Cocoa
  class NSURLDownload < Cocoa::NSObject
    attach_singular_method :canResumeDownloadDecodedWithEncodingMIMEType, :args=>1, :names=>[], :types=>["@"], :retval=>"B"
    attach_method :cancel, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :deletesFileUponFailure, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :initWithRequest, :args=>2, :names=>["delegate"], :types=>["@", "@"], :retval=>"@"
    attach_method :initWithResumeData, :args=>3, :names=>["delegate", "path"], :types=>["@", "@", "@"], :retval=>"@"
    attach_method :request, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :resumeData, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :setDeletesFileUponFailure, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setDestination, :args=>2, :names=>["allowOverwrite"], :types=>["@", "B"], :retval=>"v"
  end
end