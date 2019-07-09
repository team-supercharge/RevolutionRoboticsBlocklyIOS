//
//  ViewController.swift
//  RevolutionRoboticsBlockly
//
//  Created by Gabor Nagy Farkas on 04/10/2019.
//  Copyright (c) 2019 Gabor Nagy Farkas. All rights reserved.
//

import UIKit
import RevolutionRoboticsBlockly

class ViewController: UIViewController {
    @IBAction func blocklyButtonTapped(_ sender: Any) {
        let blockly = BlocklyViewController()
        blockly.setup(blocklyBridgeDelegate: self)
        navigationController?.pushViewController(blockly, animated: true)
    }
}

// MARK: - BlocklyBridgeDelegate
extension ViewController: BlocklyBridgeDelegate {
    func onBlocklyLoaded() {
        print("Blockly loaded")
    }

    func alert(message: String, callback: (() -> Void)?) {
        presentAlert(title: message, message: nil, callback: callback)
    }

    func confirm(message: String, callback: ((Bool) -> Void)?) {
        presentConfirmAlert(title: message, callback: callback)
    }

    public func optionSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?) {
        presentOptionSelectorAlert(
            title: optionSelector.title,
            type: "Option Selector",
            options: optionSelector.options,
            callback: callback
        )
    }

    public func driveDirectionSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?) {
        presentOptionSelectorAlert(
            title: optionSelector.title,
            type: "Drive Direction Selector",
            options: optionSelector.options,
            callback: callback
        )
    }

    public func colorSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?) {
        presentOptionSelectorAlert(
            title: optionSelector.title,
            type: "Color Selector",
            options: optionSelector.options,
            callback: callback
        )
    }

    public func audioSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?) {
        presentOptionSelectorAlert(
            title: optionSelector.title,
            type: "Audio Selector",
            options: optionSelector.options,
            callback: callback
        )
    }

    public func sliderHandler(_ sliderHandler: SliderHandler, callback: ((String?) -> Void)?) {
        presentInputAlert(
            title: "Slider Input Handler",
            type: "Minimum value = \(sliderHandler.minimum), Maximum value = \(sliderHandler.maximum)",
            defaultText: sliderHandler.defaultValue,
            callback: callback
        )
    }

    public func singleLEDInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?) {
        presentInputAlert(
            title: inputHandler.title,
            type: "Single LED Input Handler",
            defaultText: inputHandler.defaultInput,
            callback: callback
        )
    }

    public func multiLEDInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?) {
        presentInputAlert(
            title: inputHandler.title,
            type: "Multi LED Input Handler",
            defaultText: inputHandler.defaultInput,
            callback: callback
        )
    }

    public func numberInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?) {
        presentInputAlert(
            title: inputHandler.title,
            type: "Number Input Handler",
            defaultText: inputHandler.defaultInput,
            callback: callback
        )
    }

    public func textInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?) {
        presentInputAlert(
            title: inputHandler.title,
            type: "Text Input Handler",
            defaultText: inputHandler.defaultInput,
            callback: callback
        )
    }

    public func variableContext(_ optionSelector: OptionSelector, callback: ((VariableContextAction?) -> Void)?) {
        presentOptionSelectorAlert(
            title: optionSelector.title,
            type: "Variable Context Action",
            options: optionSelector.options.dropLast()
        ) { [weak self] selectedOption in
            let actionSelected: ((Bool) -> Void) = { deleteSelected in
                let action: VariableContextAction = deleteSelected
                    ? DeleteVariableAction(payload: selectedOption!)
                    : SetVariableAction(payload: selectedOption!)
                callback?(action)
            }

            self?.presentConfirmAlert(
                title: "Would you like to set or delete the variable?",
                leftButtonTitle: "Set",
                rightButtonTitle: "Delete",
                callback: actionSelected
            )
        }
    }

    public func blockContext (_ contextHandler: BlockContextHandler, callback: ((BlockContextAction?) -> Void)?) {
        let alert = UIAlertController(title: contextHandler.title, message: "Block Context", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = contextHandler.comment
        }

        let addCommentAction = UIAlertAction(title: "Add Comment", style: .default) { _ in
            let textInput = alert.textFields![0] as UITextField
            callback?(AddCommentAction(payload: textInput.text))
        }
        alert.addAction(addCommentAction)

        let duplicateAction = UIAlertAction(title: "Duplicate", style: .default) { _ in
            callback?(DuplicateBlockAction())
        }
        alert.addAction(duplicateAction)

        let helpAction = UIAlertAction(title: "Help", style: .default) { _ in
            callback?(HelpAction())
        }
        alert.addAction(helpAction)

        let deleteAction = UIAlertAction(title: "Delete", style: .default) { _ in
            callback?(DeleteBlockAction())
        }
        alert.addAction(deleteAction)

        present(alert, animated: true)
    }

    public func onVariablesExported(variables: String) {
        presentAlert(title: "Variables", message: variables, callback: nil)
    }

    public func onPythonProgramSaved(pythonCode: String) {
        presentAlert(title: "Python Code", message: pythonCode, callback: nil)
    }

    public func onXMLProgramSaved(xmlCode: String) {
        presentAlert(title: "XML Code", message: xmlCode, callback: nil)
    }
}

// MARK: - Alert helpers
extension ViewController {
    private func presentAlert(title: String, message: String?, callback: (() -> (Void))?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            callback?()
        }
        alert.addAction(okAction)

        present(alert, animated: true)
    }

    private func presentConfirmAlert(
        title: String,
        leftButtonTitle: String = "Cancel",
        rightButtonTitle: String = "OK",
        callback: ((Bool) -> (Void))? = nil
    ) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)

        let okAction = UIAlertAction(title: rightButtonTitle, style: .default) { _ in
            callback?(true)
        }
        alert.addAction(okAction)

        let cancelAction = UIAlertAction(title: leftButtonTitle, style: .cancel) { _ in
            callback?(false)
        }
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

    private func presentOptionSelectorAlert(title: String?, type: String, options: [Option], callback: ((String?) -> (Void))?) {
        let alert = UIAlertController(title: title, message: type, preferredStyle: .alert)

        options.forEach { option in
            let action = UIAlertAction(title: option.value, style: .default) { _ in
                callback?(option.key)
            }

            alert.addAction(action)
        }

        present(alert, animated: true)
    }

    private func presentInputAlert(title: String, type: String, defaultText: String?, callback: ((String?) -> (Void))?) {
        let alert = UIAlertController(title: title, message: type, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = defaultText
        }

        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            let textInput = alert.textFields![0] as UITextField
            callback?(textInput.text)
        }
        alert.addAction(doneAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            callback?(nil)
        }
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
}
