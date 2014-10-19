class WindowController < NSWindowController
  attr_accessor :layout
  def init
    @servers = LoadServers.get_json

    super.tap do
      @layout = WindowLayout.new
      self.window = @layout.window
      #self.window.delegate = self

      @table_view = @layout.get(:table_view)
      @table_view.delegate = self
      @table_view.dataSource = self

      @button = @layout.get(:button)
      @button.setTarget self
      @button.setAction 'applyChanges:'
    end
  end

  def applyChanges(what)
    new_servers = []
    sri =  @table_view.selectedRowIndexes
    sri.enumerateIndexesUsingBlock ->(idx, stop) {
      new_servers << @servers[idx]['ipaddress']
    }
    DynamicStore.switchDNS new_servers
  end

  def numberOfRowsInTableView(table_view)
    (@servers || []).length
  end

  def tableView(table_view, viewForTableColumn: column, row: row)
    text_field = table_view.makeViewWithIdentifier(column.identifier, owner: self)

    unless text_field
      text_field = NSTextField.alloc.initWithFrame([[0, 0], [column.width, 0]])
      text_field.identifier = column.identifier
      text_field.editable = false
      text_field.drawsBackground = false
      text_field.bezeled = false
    end

    row = @servers[row]

    text_field.stringValue = row[column.identifier]

    return text_field
  end
end
