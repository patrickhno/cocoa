# generated by 'rake generate'
require 'cocoa/bindings/NSObject'
module Cocoa
  class NSOpenGLContext < Cocoa::NSObject
    attach_method :CGLContextObj, :args=>0, :names=>[], :types=>[], :retval=>"^v"
    attach_singular_method :clearCurrentContext, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :clearDrawable, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :copyAttributesFromContext, :args=>2, :names=>[:withMask], :types=>["@", "I"], :retval=>"v"
    attach_method :createTexture, :args=>3, :names=>[:fromView, :internalFormat], :types=>["I", "@", "I"], :retval=>"v"
    attach_singular_method :currentContext, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :currentVirtualScreen, :args=>0, :names=>[], :types=>[], :retval=>"i"
    attach_method :flushBuffer, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :getValues, :args=>2, :names=>[:forParameter], :types=>["^i", "i"], :retval=>"v"
    attach_method :initWithCGLContextObj, :args=>1, :names=>[], :types=>["^v"], :retval=>"@"
    attach_method :initWithFormat, :args=>2, :names=>[:shareContext], :types=>["@", "@"], :retval=>"@"
    attach_method :makeCurrentContext, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :pixelBuffer, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :pixelBufferCubeMapFace, :args=>0, :names=>[], :types=>[], :retval=>"I"
    attach_method :pixelBufferMipMapLevel, :args=>0, :names=>[], :types=>[], :retval=>"i"
    attach_method :setCurrentVirtualScreen, :args=>1, :names=>[], :types=>["i"], :retval=>"v"
    attach_method :setFullScreen, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :setOffScreen, :args=>4, :names=>[:width, :height, :rowbytes], :types=>["^v", "i", "i", "i"], :retval=>"v"
    attach_method :setPixelBuffer, :args=>4, :names=>[:cubeMapFace, :mipMapLevel, :currentVirtualScreen], :types=>["@", "I", "i", "i"], :retval=>"v"
    attach_method :setTextureImageToPixelBuffer, :args=>2, :names=>[:colorBuffer], :types=>["@", "I"], :retval=>"v"
    attach_method :setValues, :args=>2, :names=>[:forParameter], :types=>["^i", "i"], :retval=>"v"
    attach_method :setView, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :update, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :view, :args=>0, :names=>[], :types=>[], :retval=>"@"
  end
end
