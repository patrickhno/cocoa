# generated by 'rake generate'
require 'cocoa/bindings/NSControl'
module Cocoa
  class NSScroller < Cocoa::NSControl
    attach_method :arrowsPosition, :args=>0, :names=>[], :types=>[], :retval=>"Q"
    attach_method :checkSpaceForParts, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :controlSize, :args=>0, :names=>[], :types=>[], :retval=>"Q"
    attach_method :controlTint, :args=>0, :names=>[], :types=>[], :retval=>"Q"
    attach_method :drawArrow, :args=>2, :names=>["highlight"], :types=>["Q", "B"], :retval=>"v"
    attach_method :drawKnob, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :drawKnobSlotInRect, :args=>2, :names=>["highlight"], :types=>["{CGRect={CGPoint=dd}{CGSize=dd}}", "B"], :retval=>"v"
    attach_method :drawParts, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :highlight, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :hitPart, :args=>0, :names=>[], :types=>[], :retval=>"Q"
    attach_singular_method :isCompatibleWithOverlayScrollers, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :knobProportion, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :knobStyle, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_singular_method :preferredScrollerStyle, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_method :rectForPart, :args=>1, :names=>[], :types=>["Q"], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :scrollerStyle, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_singular_method :scrollerWidth, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_singular_method :scrollerWidthForControlSize, [{:args=>1, :names=>[], :types=>["Q"], :retval=>"d"}, {:args=>2, :names=>["scrollerStyle"], :types=>["Q", "q"], :retval=>"d"}]
    attach_method :setArrowsPosition, :args=>1, :names=>[], :types=>["Q"], :retval=>"v"
    attach_method :setControlSize, :args=>1, :names=>[], :types=>["Q"], :retval=>"v"
    attach_method :setControlTint, :args=>1, :names=>[], :types=>["Q"], :retval=>"v"
    attach_method :setFloatValue, :args=>2, :names=>["knobProportion"], :types=>["f", "d"], :retval=>"v"
    attach_method :setKnobProportion, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :setKnobStyle, :args=>1, :names=>[], :types=>["q"], :retval=>"v"
    attach_method :setScrollerStyle, :args=>1, :names=>[], :types=>["q"], :retval=>"v"
    attach_method :testPart, :args=>1, :names=>[], :types=>["{CGPoint=dd}"], :retval=>"Q"
    attach_method :trackKnob, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :trackScrollButtons, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :usableParts, :args=>0, :names=>[], :types=>[], :retval=>"Q"
  end
end