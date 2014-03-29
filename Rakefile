# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'motion-cocoapods'
require 'bubble-wrap'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Quartermaster'
  app.identifier = 'com.moubry.quartermaster'
  app.pods do
    pod 'sundown'
  end
  app.icons = ["Icon.png", "Icon-57.png", "Icon@2x.png"]
  app.prerendered_icon = true
  app.provisioning_profile = '/Users/sean/Library/MobileDevice/Provisioning Profiles/CB2EECC8-A064-475A-AEC8-074B8A310A15.mobileprovision'
  app.codesign_certificate = 'iPhone Developer: Sean Moubry (6L2W699658)'
end
