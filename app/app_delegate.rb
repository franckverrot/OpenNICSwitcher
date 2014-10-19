class AppDelegate
  def applicationDidFinishLaunching(notification)
    NSApp.mainMenu = MainMenu.new.menu

    @controller = WindowController.alloc.init

    @controller.showWindow(self)
    @controller.window.orderFrontRegardless
    @controller.layout.get(:table_view).selectRowIndexes NSIndexSet.indexSetWithIndex(0), byExtendingSelection: false

    buildStatusBar
  end

  def buildStatusBar
    status = NSStatusBar.systemStatusBar
    @item = status.statusItemWithLength(NSSquareStatusItemLength)
    @statusView = StatusView.alloc.initWithFrame [[0.0, 0.0],[16.0, 16.0]]
    @statusView.statusItem = @item
    @item.setHighlightMode true
    menu = NSMenu.new
    menu.addItemWithTitle('Quit', action: 'terminate:', keyEquivalent: 'q')
    @statusView.menu = menu
    @statusView.window_controller = @controller

  end
end
