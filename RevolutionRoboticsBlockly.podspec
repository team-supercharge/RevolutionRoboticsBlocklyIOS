#
# Be sure to run `pod lib lint RevolutionRoboticsBlockly.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RevolutionRoboticsBlockly'
  s.version          = '0.1.2'
  s.summary          = 'A short description of RevolutionRoboticsBlockly.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://gitlab.supercharge.io/revolutionrobotics/blockly-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author   = {
        'Mate Papp' => 'mate.papp@supercharge.io',
        'Gabor Nagy Farkas' => 'gabor.nagy.farkas@supercharge.io'
    }
  # Before release append the tag to the source ⚠️ ⚠️ ⚠️
  s.source           = { :git => 'https://gitlab.supercharge.io/revolutionrobotics/blockly-ios' }#, :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'

  s.source_files = 'RevolutionRoboticsBlockly/Classes/**/*.{swift}'
  s.resources = ['RevolutionRoboticsBlockly/Assets/**/*.{png,jpeg,jpg,xcassets,mp3}', 'RevolutionRoboticsBlockly/Classes/**/*.{xib}', 'blockly-js/Blockly/**/*']

  # s.resource_bundles = {
  #   'RevolutionRoboticsBlockly' => ['RevolutionRoboticsBlockly/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'WebKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
