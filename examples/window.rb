require 'cocoa'

class MyApplication < Cocoa::NSObject
  def applicationDidFinishLaunching notification
    menubar = NSMenu.new.autorelease
    app_menu_item = NSMenuItem.new.autorelease
    menubar.addItem app_menu_item
    $application.setMainMenu menubar

    app_menu = NSMenu.new.autorelease
    quit_menu_item = NSMenuItem.alloc.initWithTitle("Quit",
      action: :terminate,
      keyEquivalent: 'q'
    ).autorelease
    app_menu.addItem quit_menu_item
    app_menu_item.setSubmenu app_menu

    window = NSWindow.alloc.initWithContentRect(NSRect.new(x: 0, y: 0, width: 200, height: 200),
      styleMask: NSTitledWindowMask | NSResizableWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    window.setMinSize NSSize.new(width: 200, height: 200)

    point = CGPoint.new
    point[:x] = 20.0
    point[:y] = 20.0
    window.cascadeTopLeftFromPoint point
    window.setTitle "Test app"
    window.makeKeyAndOrderFront nil

    $application.activateIgnoringOtherApps true
  end
end

Cocoa::NSAutoreleasePool.new
$application = Cocoa::NSApplication.sharedApplication
$application.setActivationPolicy Cocoa::NSApplicationActivationPolicyRegular

appDelegate = MyApplication.alloc.init.autorelease
$application.setDelegate appDelegate
$application.run
