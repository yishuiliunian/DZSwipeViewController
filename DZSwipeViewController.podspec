#
# Be sure to run `pod lib lint DZSwipeViewController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "DZSwipeViewController"
  s.version          = "0.1.7"
  s.summary          = "DZSwipeViewController，左右滑动的视图控制器，支持顶部样式自定义。"
  s.description      = <<-DESC
                       DZSwipeViewController，左右滑动的视图控制器，支持顶部样式自定义。方便用来实现顶部Tab的视图管理器，支持视图左右滑动。
                       DESC
  s.homepage         = "https://github.com/yishuiliunian/DZSwipeViewController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "stonedong" => "yishuiliunian@gmail.com" }
  s.source           = { :git => "https://github.com/yishuiliunian/DZSwipeViewController.git", :tag => s.version.to_s }

  s.platform     = :ios, '5.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DZSwipeViewController' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'DZGeometryTools'
end