# generated by 'rake generate'
require 'cocoa/bindings/NSObject'
module Cocoa
  class CALayer < Cocoa::NSObject
    attach_method :actionForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_method :actions, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :addAnimation, :args=>2, :names=>[:forKey], :types=>["@", "@"], :retval=>"v"
    attach_method :addConstraint, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :addSublayer, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :affineTransform, :args=>0, :names=>[], :types=>[], :retval=>"{CGAffineTransform=dddddd}"
    attach_method :anchorPoint, :args=>0, :names=>[], :types=>[], :retval=>"{CGPoint=dd}"
    attach_method :anchorPointZ, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :animationForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_method :animationKeys, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :autoresizingMask, :args=>0, :names=>[], :types=>[], :retval=>"I"
    attach_method :backgroundColor, :args=>0, :names=>[], :types=>[], :retval=>"^{CGColor=}"
    attach_method :backgroundFilters, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :borderColor, :args=>0, :names=>[], :types=>[], :retval=>"^{CGColor=}"
    attach_method :borderWidth, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :bounds, :args=>0, :names=>[], :types=>[], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :compositingFilter, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :constraints, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :containsPoint, :args=>1, :names=>[], :types=>["{CGPoint=dd}"], :retval=>"B"
    attach_method :contents, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :contentsAreFlipped, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :contentsCenter, :args=>0, :names=>[], :types=>[], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :contentsGravity, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :contentsRect, :args=>0, :names=>[], :types=>[], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :contentsScale, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :convertPoint, [{:args=>2, :names=>[:fromLayer], :types=>["{CGPoint=dd}", "@"], :retval=>"{CGPoint=dd}"}, {:args=>2, :names=>[:toLayer], :types=>["{CGPoint=dd}", "@"], :retval=>"{CGPoint=dd}"}]
    attach_method :convertRect, [{:args=>2, :names=>[:fromLayer], :types=>["{CGRect={CGPoint=dd}{CGSize=dd}}", "@"], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"}, {:args=>2, :names=>[:toLayer], :types=>["{CGRect={CGPoint=dd}{CGSize=dd}}", "@"], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"}]
    attach_method :convertTime, [{:args=>2, :names=>[:fromLayer], :types=>["d", "@"], :retval=>"d"}, {:args=>2, :names=>[:toLayer], :types=>["d", "@"], :retval=>"d"}]
    attach_method :cornerRadius, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_singular_method :defaultActionForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_singular_method :defaultValueForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_method :delegate, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :display, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :displayIfNeeded, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :drawInContext, :args=>1, :names=>[], :types=>["^{CGContext=}"], :retval=>"v"
    attach_method :drawsAsynchronously, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :edgeAntialiasingMask, :args=>0, :names=>[], :types=>[], :retval=>"I"
    attach_method :filters, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :frame, :args=>0, :names=>[], :types=>[], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :hitTest, :args=>1, :names=>[], :types=>["{CGPoint=dd}"], :retval=>"@"
    attach_method :init, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :initWithLayer, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_method :insertSublayer, [{:args=>2, :names=>[:above], :types=>["@", "@"], :retval=>"v"}, {:args=>2, :names=>[:atIndex], :types=>["@", "I"], :retval=>"v"}, {:args=>2, :names=>[:below], :types=>["@", "@"], :retval=>"v"}]
    attach_method :isDoubleSided, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :isGeometryFlipped, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :isHidden, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :isOpaque, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_singular_method :layer, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_singular_method :layerWithRemoteClientId, :args=>1, :names=>[], :types=>["I"], :retval=>"@"
    attach_method :layoutIfNeeded, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :layoutManager, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :layoutSublayers, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :magnificationFilter, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :mask, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :masksToBounds, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :minificationFilter, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :minificationFilterBias, :args=>0, :names=>[], :types=>[], :retval=>"f"
    attach_method :modelLayer, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :name, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :needsDisplay, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_singular_method :needsDisplayForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"B"
    attach_method :needsDisplayOnBoundsChange, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :needsLayout, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :opacity, :args=>0, :names=>[], :types=>[], :retval=>"f"
    attach_method :position, :args=>0, :names=>[], :types=>[], :retval=>"{CGPoint=dd}"
    attach_method :preferredFrameSize, :args=>0, :names=>[], :types=>[], :retval=>"{CGSize=dd}"
    attach_method :presentationLayer, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :rasterizationScale, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :removeAllAnimations, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :removeAnimationForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :removeFromSuperlayer, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :renderInContext, :args=>1, :names=>[], :types=>["^{CGContext=}"], :retval=>"v"
    attach_method :replaceSublayer, :args=>2, :names=>[:with], :types=>["@", "@"], :retval=>"v"
    attach_method :resizeSublayersWithOldSize, :args=>1, :names=>[], :types=>["{CGSize=dd}"], :retval=>"v"
    attach_method :resizeWithOldSuperlayerSize, :args=>1, :names=>[], :types=>["{CGSize=dd}"], :retval=>"v"
    attach_method :scrollPoint, :args=>1, :names=>[], :types=>["{CGPoint=dd}"], :retval=>"v"
    attach_method :scrollRectToVisible, :args=>1, :names=>[], :types=>["{CGRect={CGPoint=dd}{CGSize=dd}}"], :retval=>"v"
    attach_method :setActions, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setAffineTransform, :args=>1, :names=>[], :types=>["{CGAffineTransform=dddddd}"], :retval=>"v"
    attach_method :setAnchorPoint, :args=>1, :names=>[], :types=>["{CGPoint=dd}"], :retval=>"v"
    attach_method :setAnchorPointZ, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :setAutoresizingMask, :args=>1, :names=>[], :types=>["I"], :retval=>"v"
    attach_method :setBackgroundColor, :args=>1, :names=>[], :types=>["^{CGColor=}"], :retval=>"v"
    attach_method :setBackgroundFilters, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setBorderColor, :args=>1, :names=>[], :types=>["^{CGColor=}"], :retval=>"v"
    attach_method :setBorderWidth, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :setBounds, :args=>1, :names=>[], :types=>["{CGRect={CGPoint=dd}{CGSize=dd}}"], :retval=>"v"
    attach_method :setCompositingFilter, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setConstraints, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setContents, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setContentsCenter, :args=>1, :names=>[], :types=>["{CGRect={CGPoint=dd}{CGSize=dd}}"], :retval=>"v"
    attach_method :setContentsGravity, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setContentsRect, :args=>1, :names=>[], :types=>["{CGRect={CGPoint=dd}{CGSize=dd}}"], :retval=>"v"
    attach_method :setContentsScale, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :setCornerRadius, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :setDelegate, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setDoubleSided, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setDrawsAsynchronously, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setEdgeAntialiasingMask, :args=>1, :names=>[], :types=>["I"], :retval=>"v"
    attach_method :setFilters, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setFrame, :args=>1, :names=>[], :types=>["{CGRect={CGPoint=dd}{CGSize=dd}}"], :retval=>"v"
    attach_method :setGeometryFlipped, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setHidden, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setLayoutManager, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setMagnificationFilter, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setMask, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setMasksToBounds, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setMinificationFilter, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setMinificationFilterBias, :args=>1, :names=>[], :types=>["f"], :retval=>"v"
    attach_method :setName, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setNeedsDisplay, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :setNeedsDisplayInRect, :args=>1, :names=>[], :types=>["{CGRect={CGPoint=dd}{CGSize=dd}}"], :retval=>"v"
    attach_method :setNeedsDisplayOnBoundsChange, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setNeedsLayout, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :setOpacity, :args=>1, :names=>[], :types=>["f"], :retval=>"v"
    attach_method :setOpaque, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setPosition, :args=>1, :names=>[], :types=>["{CGPoint=dd}"], :retval=>"v"
    attach_method :setRasterizationScale, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :setShadowColor, :args=>1, :names=>[], :types=>["^{CGColor=}"], :retval=>"v"
    attach_method :setShadowOffset, :args=>1, :names=>[], :types=>["{CGSize=dd}"], :retval=>"v"
    attach_method :setShadowOpacity, :args=>1, :names=>[], :types=>["f"], :retval=>"v"
    attach_method :setShadowPath, :args=>1, :names=>[], :types=>["^{CGPath=}"], :retval=>"v"
    attach_method :setShadowRadius, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :setShouldRasterize, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setStyle, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setSublayerTransform, :args=>1, :names=>[], :types=>["{CATransform3D=dddddddddddddddd}"], :retval=>"v"
    attach_method :setSublayers, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setTransform, :args=>1, :names=>[], :types=>["{CATransform3D=dddddddddddddddd}"], :retval=>"v"
    attach_method :setZPosition, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :shadowColor, :args=>0, :names=>[], :types=>[], :retval=>"^{CGColor=}"
    attach_method :shadowOffset, :args=>0, :names=>[], :types=>[], :retval=>"{CGSize=dd}"
    attach_method :shadowOpacity, :args=>0, :names=>[], :types=>[], :retval=>"f"
    attach_method :shadowPath, :args=>0, :names=>[], :types=>[], :retval=>"^{CGPath=}"
    attach_method :shadowRadius, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :shouldArchiveValueForKey, :args=>1, :names=>[], :types=>["@"], :retval=>"B"
    attach_method :shouldRasterize, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :style, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :sublayerTransform, :args=>0, :names=>[], :types=>[], :retval=>"{CATransform3D=dddddddddddddddd}"
    attach_method :sublayers, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :superlayer, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :transform, :args=>0, :names=>[], :types=>[], :retval=>"{CATransform3D=dddddddddddddddd}"
    attach_method :visibleRect, :args=>0, :names=>[], :types=>[], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :zPosition, :args=>0, :names=>[], :types=>[], :retval=>"d"
  end
end
