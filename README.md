# Revolution Robotics Blockly Code Editor iOS SDK

[![Build](https://github.com/RevolutionRobotics/RevolutionRoboticsBlocklyIOS/workflows/build/badge.svg)](https://github.com/RevolutionRobotics/RevolutionRoboticsBlocklyIOS/actions)
[![Version](https://img.shields.io/cocoapods/v/RevolutionRoboticsBlockly.svg?style=flat)](https://cocoapods.org/pods/RevolutionRoboticsBlockly)
[![License](https://img.shields.io/cocoapods/l/RevolutionRoboticsBlockly.svg?style=flat)](https://cocoapods.org/pods/RevolutionRoboticsBlockly)
[![support](https://img.shields.io/badge/support-iOS%2011%2B%20-FB7DEC.svg?style=flat)](https://www.apple.com/nl/ios/ios-13/)
[![Swift](https://img.shields.io/badge/swift-5.0-orange.svg)](https://github.com/apple/swift)

## Introduction

**Revolution Robotics Blockly** is built on Google’s [open-source Blockly library](https://opensource.google.com/projects/blockly), which represents coding concepts as interlocking blocks, and transforms these blocks into syntactically correct source code.

This library allows you to embed the Blockly coding interface customised specially for Revolution Robotics’ robots. It consists many custom blocks to enable you to program the robots and utilise all their features. Under the hood it wraps the [official Blockly JavaScript library](https://github.com/google/blockly) in a WebView and creates the communication bridge between the WebView and native code.

## Requirements

- iOS 11.0+
- Swift 5.0+
- Xcode 10.2+

## Installation

RevolutionRoboticsBlockly is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RevolutionRoboticsBlockly'
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## BlocklyViewController

The core of the Robotics Blockly iOS SDK is the `BlocklyViewController` `UIViewController` subclass, which encapsulates all the features of the blockly editor. You can use this view to embed the code editor to your layout like any `UIViewController` either from Storyboards, XIBs, or code.

### Methods

`BlocklyViewController` provides some features to manipulate its contents

```swift
func setup(blocklyBridgeDelegate: BlocklyBridgeDelegate)
```

If you want receive events from `BlocklyViewController` you have to conform to the `BlocklyBridgeDelegate` protocol by calling the viewController's setup method.

```swift
func saveProgram()
```

Save the contents of the workspace. The result of the program saving will trigger three separate `BlocklyBridgeDelegate` method.

- `onVariablesExported(variables: String)`
- `onPythonProgramSaved(pythonCode: String)`
- `onXMLProgramSaved(xmlCode: String)`

```swift
func loadProgram(xml: String)
```

Load the contents of a blockly XML file string into the workspace.

```swift
func clearWorkspace()
```

Removes all blocks from the workspace.

## BlocklyBridgeDelegate

Many Blockly features, mostly blocks, require input from the user. Communications are done through dialogs. To make the dialogs' appearance fully customizable you have to provide the UI, while responses are handled by the framework using the corresponding delegate method's callback. For example, when creating a variable, Blockly raises a text input dialog, so the user can provide the variable's name, and then provided name is passed back to the editor with the callback block.

Every event handler method has a callback block which receives the required response type (most of the cases a `String`) or `nil` if you want to cancel the event. Either one of these results **must** be called because `BlocklyViewController` is blocked until one of them is called. **WARNING! It will be crashed if you don't use the callback.**

### Methods

`BlocklyBridgeDelegate` has the following methods to display modals or handle events

```swift
func alert(message: String, callback: (() -> Void)?)
```

Display an alert for the user with a message. Invoking the callback means you accepted the alert.

```swift
func confirm(message: String, callback: ((Bool) -> Void)?)
```

Let the user confirm an action with a message. The callback receives `true` or `false` which indicates the result of the confirmation.

```swift
func optionSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?)
```

Show custom options for the user. The available options come in an array, which has 2 to 6 options. Comes with a default selection if applicable. The callback receives `nil` or the selected option's **key**.

```swift
func driveDirectionSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?)
```

Shows a drive direction selector modal for the user. Comes with a default selection if applicable. The callback receives `nil` or the selected direction option's **key**.

```swift
func colorSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?)
```

Show a color picker for the user with the given color set. Comes with a default value if applicable. The callback receives `nil` or the selected color option's **key**.

```swift
func audioSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?)
```

Show a sound picker for the user. This will display all the sound files available on the robot. Comes with a default value if applicable. The callback receives `nil` or the selected sound option's **key**.

```swift
func sliderHandler(_ sliderHandler: SliderHandler, callback: ((String?) -> Void)?)
```

Show a modal with a slider so the user can input a number. Comes with a default, minimum and a maximum value if applicable. The callback receives `nil` or the selected value as a `String`.

```swift
func singleLEDInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?)
func multiLEDInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?)
```

Show a led selector for the user, preferably in a round shape mimicking the LED display on the robot (hence the name, “DonutSelector”). There are two types of LED selection, single (where the user can select a single LED) and multi (where the user can select any number of LEDs). Comes with a default selection if applicable. The callback receives `nil` or in case of

- **Single LED**: the selected LED position (from 1 to 12) as a `String`
- **Multi LED**: the selected LED positions (from 1 to 12) separated by a comma as a `String`. (example: `"3,5,7"`)

```swift
func numberInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?)
```

Show a number input modal so the user can input floating point values. Comes with a default value if applicable. The callback receives `nil` or the number as a `String`.

```swift
func textInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?)
```

Show a text input for the user. Comes with a default value if applicable. The callback receives `nil` or the text.

```swift
func variableContext(_ optionSelector: OptionSelector, callback: ((VariableContextAction?) -> Void)?)
```

Show the variable context modal for the user, where the user can switch the variable to another one, or delete a variable. The callback receives `nil` or either a `DeleteVariableAction(payload: String)` or a `SetVariableAction(payload: String)` which payload is the related variable what you want to delete or set.

```swift
func blockContext(_ contextHandler: BlockContextHandler, callback: ((BlockContextAction?) -> Void)?)
```

Show the block options dialog for the user, where the user can add a comment to the given block, delete it, duplicate it, or get help about it. The callback receives `nil` or an action from `DuplicateBlockAction()`, `HelpAction()`, `DeleteBlockAction()` or an `AddCommentAction(payload: String)` which payload is the comment's text.

```swift
func onVariablesExported(variables: String)
```

Export all the variables used as ports in the source, so you can determine which programs are compatible with which configurations (the configuration should have all the variable names as port names defined to be considered compatible).

```swift
func onPythonProgramSaved(pythonCode: String)
```

Export the python code is generated, which holds the syntactically correct source code of the program assembled in the editor. This python code can be uploaded and run on the robot.

```swift
func onXMLProgramSaved(xmlCode: String)
```

Export the XML generated represents the current state of the blockly workspace. This can be used to reload programs into the workspace later.

```swift
func onBlocklyLoaded()
```

Receive an event when Blockly successfully loaded in the WebView.

## Author

Mate Papp mate.papp@supercharge.io

## License

RevolutionRoboticsBlockly is available under the MIT license. See the LICENSE file for more info.
