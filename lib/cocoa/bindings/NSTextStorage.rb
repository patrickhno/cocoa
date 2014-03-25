# generated by 'rake generate'
require 'cocoa/bindings/NSMutableAttributedString'
module Cocoa
  class NSTextStorage < Cocoa::NSMutableAttributedString
    attach_method :addLayoutManager, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :attributeRuns, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :changeInLength, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_method :characters, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :delegate, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :edited, :args=>3, :names=>["range", "changeInLength"], :types=>["Q", "{_NSRange=QQ}", "q"], :retval=>"v"
    attach_method :editedMask, :args=>0, :names=>[], :types=>[], :retval=>"Q"
    attach_method :editedRange, :args=>0, :names=>[], :types=>[], :retval=>"{_NSRange=QQ}"
    attach_method :ensureAttributesAreFixedInRange, :args=>1, :names=>[], :types=>["{_NSRange=QQ}"], :retval=>"v"
    attach_method :fixesAttributesLazily, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :font, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :foregroundColor, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :invalidateAttributesInRange, :args=>1, :names=>[], :types=>["{_NSRange=QQ}"], :retval=>"v"
    attach_method :layoutManagers, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :paragraphs, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :processEditing, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :removeLayoutManager, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setAttributeRuns, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setCharacters, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setDelegate, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setFont, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setForegroundColor, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setParagraphs, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setWords, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :words, :args=>0, :names=>[], :types=>[], :retval=>"@"
  end
end