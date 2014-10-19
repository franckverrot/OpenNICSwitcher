class WindowLayout < MK::WindowLayout
  WIDTH=640
  HEIGHT=480

  def layout
    root(:window) do
      add NSScrollView, :table_scroll_view do
        document_view add NSTableView, :table_view
        has_vertical_scroller true
      end
      add NSButton, :button
      add NSTextField, :text_field
    end
  end

  def window_style
    initial do
      title NSBundle.mainBundle.infoDictionary['CFBundleName']
      width WIDTH
      height HEIGHT
      frame from_center
      style_mask (style_mask & ~NSResizableWindowMask)
    end
  end

  def text_field_style
    initial do
      font NSFont.boldSystemFontOfSize(20)
      stringValue 'Select your DNS servers and apply!'
      alignment NSCenterTextAlignment
      background_color NSColor.blackColor
      text_color NSColor.whiteColor
      editable false
      parent_bounds = [[0, HEIGHT-60], [WIDTH, 40]]
      frame parent_bounds
    end
  end

  def table_scroll_view_style
    parent_bounds = [[0, 40], [WIDTH, HEIGHT-100]]
    frame parent_bounds
    autoresizing_mask NSViewWidthSizable | NSViewHeightSizable
  end

  def button_style
    initial do
      font NSFont.boldSystemFontOfSize(20)
      title 'Apply changes'
      frame [[0, 0], [WIDTH, 40]]
    end
  end

  def table_view_style
    uses_alternating_row_background_colors true
    row_height 24
    frame [[0, 40], [WIDTH, HEIGHT-100]]
    set_allows_multiple_selection true

    add_column('status') do
      title 'Status'
      width 50
      resizingMask NSTableColumnAutoresizingMask
    end

    add_column('ipaddress') do
      title 'IP Address'
      width 100
      resizingMask NSTableColumnAutoresizingMask
    end

    add_column('hostname') do
      title 'Hostname'
      width 200
      resizingMask NSTableColumnAutoresizingMask
    end

    add_column('owner') do
      title 'Owner'
      width 100
      resizingMask NSTableColumnAutoresizingMask
    end

    add_column('city') do
      title 'City'
      width 30
      resizingMask NSTableColumnAutoresizingMask
    end

    add_column('country') do
      title 'Country'
      width 30
      resizingMask NSTableColumnAutoresizingMask
    end

    add_column('last_verified') do
      title 'Last verified'
      width 100
      resizingMask NSTableColumnAutoresizingMask
    end

    add_column('anon_logs') do
      title 'Anonymous logs'
      width 100
      resizingMask NSTableColumnAutoresizingMask
    end

    add_column('logs') do
      title 'Logs'
      width 200
      resizingMask NSTableColumnAutoresizingMask
    end
  end
end
