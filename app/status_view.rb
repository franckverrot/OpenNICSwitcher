class StatusView < NSView
  attr_accessor :statusItem, :currentCountry, :menu, :window_controller

  def drawRect(dirtyRect)
    self.statusItem.drawStatusBarBackgroundInRect dirtyRect, withHighlight: false

    icon = imageForCountry(self.currentCountry)
    iconSize = icon.size
    bounds = self.bounds
    iconX = ((NSWidth(bounds) - iconSize.width) / 2).round
    iconY = ((NSHeight(bounds) - iconSize.height) / 2).round
    iconPoint = NSMakePoint(iconX, iconY)

    icon.drawAtPoint iconPoint, fromRect: NSZeroRect,  operation: NSCompositeSourceOver, fraction: 1.0
  end

  def statusItem=(item)
    @statusItem = item
    @statusItem.view = self
  end


  def imageForCountry(country)
    @image ||= NSImage.imageNamed "icon"
    @image.setSize(NSMakeSize(16, 16))
    @image
  end

  def mouseDown(event)
    self.setNeedsDisplay true
  end

  def rightMouseDown(event)
    showMenu
  end

  def showMenu
    statusItem.popUpStatusItemMenu @menu
    self.setNeedsDisplay true
  end
end
