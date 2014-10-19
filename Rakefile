# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

require 'bubble-wrap'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'OpenNICSwitcher'
  app.frameworks << 'SystemConfiguration'

  app.vendor_project('vendor/DynamicStore', :static, target: 'DynamicStore')
end
