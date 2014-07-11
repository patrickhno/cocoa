
require 'active_support'

require 'cocoa/helpers'
require "cocoa/bindings/NSString"

module Cocoa
  extend FFI::Library

  ffi_lib '/System/Library/Frameworks/Cocoa.framework/Cocoa'
 
  attach_function :NSApplicationLoad, [], :bool
  NSApplicationLoad()

  def const_missing name
    return CONSTANTS[name] if CONSTANTS[name]
    if File.exists?(File.dirname(__FILE__) + "/cocoa/bindings/#{name}.rb")
      require "cocoa/bindings/#{name}"
      "Cocoa::#{name}".constantize
    else
      super
    end
  end

  def method_missing name
    return CONSTANTS[name] if CONSTANTS[name]
    super
  end
end

require "cocoa/bindings/Cocoa"
require "cocoa/extensions"
