#
# Be sure to run `pod lib lint MultiStateSwitch.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MultiStateSwitch'
  s.version          = '0.1.0'
  s.summary          = 'A reusable switch control, with customizable, multiple states'

  s.description      = <<-DESC
A reusable switch control, with customizable, multiple states. Initialization can be done in two ways.
1. Storyboard Initialization:
Drag an UIView Into the storyboard. Set appropriate constraints, Change the class name field to 'MultiStateSwitch' in Identity Inspector.
2. ViewController Initialization:
Create an instance for MultiStateSwitch, specifying the array of custom images and size of the control.
let images: [UIImage] = [img1, img2, img3]
let switch = MultiStateSwitch(images, 72)

By default the control will have 2 states and no image was set
                       DESC

  s.homepage         = 'https://github.com/sarawanakumar/MultiStateSwitch'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sarawanakumar' => 'ssarawanakumar@gmail.com' }
  s.source           = { :git => 'https://github.com/sarawanakumar/MultiStateSwitch.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MultiStateSwitch/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MultiStateSwitch' => ['MultiStateSwitch/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
