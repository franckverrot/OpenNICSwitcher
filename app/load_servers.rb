class LoadServers
  def self.get_json
    local_data_file = NSBundle.mainBundle.URLForResource('servers', withExtension: 'json')
    file_content = NSMutableData.dataWithContentsOfURL(local_data_file).to_s
    BW::JSON.parse file_content
  end
end
