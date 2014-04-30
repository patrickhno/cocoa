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
    app_menu.setTitle 'Cocoa example'

    window = NSWindow.alloc.initWithContentRect(NSRect.new(x: 0, y: 0, width: 200, height: 200),
      styleMask: NSTitledWindowMask | NSResizableWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    window.setMinSize NSSize.new(width: 200, height: 200)

    # create a table view and a scroll view
    table_container = NSScrollView.alloc.initWithFrame NSMakeRect(10, 10, 380, 200)
    table_view = NSTableView.alloc.initWithFrame NSMakeRect(0, 0, 364, 200)
    # create columns for our table
    column1 = NSTableColumn.alloc.initWithIdentifier "Col1"
    column2 = NSTableColumn.alloc.initWithIdentifier "Col2"
    column1.setWidth 252
    column2.setWidth 198
    # generally you want to add at least one column to the table view.
    table_view.addTableColumn column1
    table_view.addTableColumn column2
    table_view.setDelegate self
    table_view.setDataSource self
    table_view.reloadData
    # embed the table view in the scroll view, and add the scroll view to our window.
    table_container.setDocumentView table_view
    table_container.setHasVerticalScroller true
    window.contentView.addSubview table_container
    table_container.release
    table_view.release
    column1.release
    column2.release

    point = CGPoint.new
    point[:x] = 20.0
    point[:y] = 20.0
    window.cascadeTopLeftFromPoint point
    window.setTitle "Test app"
    window.makeKeyAndOrderFront nil

    $application.activateIgnoringOtherApps true
  end

  def numberOfRowsInTableView table_view
    2
  end

  def tableView(table_view, objectValueForTableColumn: nil, row: nil)
    "#{row} #{objectValueForTableColumn.identifier}"
  end
end

Cocoa::NSAutoreleasePool.new
$application = Cocoa::NSApplication.sharedApplication
$application.setActivationPolicy Cocoa::NSApplicationActivationPolicyRegular

appDelegate = MyApplication.alloc.init.autorelease
$application.setDelegate appDelegate
$application.run
