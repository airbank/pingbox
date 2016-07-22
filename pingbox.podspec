#
# Pingbox - Simple to use in-app messaging UI for iOS.
#
# (c) 2016, Air Bank a.s.
#

Pod::Spec.new do |s|

  s.name             = 'pingbox'
  s.version          = '1.0.0'
  s.summary          = 'Simple to use in-app messaging UI for iOS.'

  s.description      = <<-DESC
Pingbox is a simple to use in-app messaging UI component for iOS apps. It shows alert-like
view stack in the bottom of the screen, with a "cancel" and "approve" buttons".
  DESC

  s.homepage         = 'https://github.com/airbank/pingbox'
  s.screenshots     = 'https://raw.githubusercontent.com/airbank/pingbox/master/docs/animation.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Petr Dvorak' => 'petr@lime-company.eu' }
  s.source           = { :git => 'https://github.com/airbank/pingbox.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/air_bank'

  s.platform = :ios, '7.0'
  s.ios.deployment_target = '7.0'

  s.source_files = 'pingbox/Classes/**/*'

  # s.resource_bundles = {
  #   'pingbox' => ['pingbox/Assets/*.png']
  # }

end
