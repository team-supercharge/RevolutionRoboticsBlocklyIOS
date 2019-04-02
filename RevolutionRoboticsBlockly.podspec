Pod::Spec.new do |s|

  s.platform = :ios
  s.ios.deployment_target = '11.0'
  s.name = "RevolutionRoboticsBlockly"
  s.summary = "RevolutionRoboticsBlockly lets users to build custom Blockly UI's for Revolution Robotics products."
  s.requires_arc = true

  s.version = "0.1.2"

  s.license = { :type => "MIT", :file => "LICENSE" }

  s.author = { "Mate Papp" => "mate.papp@supercharge.io" }

  # 5 - Replace this URL with your own GitHub page's URL (from the address bar)
  s.homepage = "https://gitlab.supercharge.io/revolutionrobotics/blockly-ios"

  s.source = { :git => "https://gitlab.supercharge.io/revolutionrobotics/blockly-ios",
               :tag => "#{s.version}" }

  s.framework = "UIKit"
  s.source_files = "RevolutionRoboticsBlockly/**/*.{swift}"
  s.resources = "RevolutionRoboticsBlockly/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  s.swift_version = "5.0"

  end