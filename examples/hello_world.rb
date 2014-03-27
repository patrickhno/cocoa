require 'cocoa'

Cocoa::NSAutoreleasePool.new
app = Cocoa::NSApplication.sharedApplication
app.setActivationPolicy Cocoa::NSApplicationActivationPolicyRegular
app.activateIgnoringOtherApps true

alert = Cocoa::NSAlert.alloc.init.autorelease
alert.setMessageText "Hello world!"
alert.runModal
