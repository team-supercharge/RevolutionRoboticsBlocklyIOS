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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func blocklyButtonTapped(_ sender: Any) {
        let blockly = BlocklyViewController()
        blockly.setup(blocklyBridgeDelegate: self)
        navigationController?.pushViewController(blockly, animated: true)
    }
}

extension ViewController: BlocklyBridgeDelegate {
    func alert(message: String, callback: (() -> Void)?) {
        callback?()
    }

    func confirm(message: String, callback: ((Bool) -> Void)?) {
        callback?(true)
    }

    public func optionSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?) {
        callback?(nil)
    }

    public func driveDirectionSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?) {
        callback?(nil)
    }

    public func colorSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?) {
        callback?(nil)
    }

    public func audioSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?) {
        callback?(nil)
    }

    public func sliderHandler(_ sliderHandler: SliderHandler, callback: ((String?) -> Void)?) {
        callback?(nil)
    }

    public func singleLEDInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?) {
        callback?(nil)
    }

    public func multiLEDInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?) {
        callback?(nil)
    }

    public func numberInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?) {
        callback?(nil)
    }

    public func textInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?) {
        callback?(nil)
    }

    public func variableContext(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?) {
        callback?(nil)
    }

    public func blockContext(_ contextHandler: BlockContextHandler, callback: ((String?) -> Void)?) {
        callback?(nil)
    }

    public func onVariablesExported(variables: String) {
        print("Receiving variables = \(variables)")
    }

    public func onPythonProgramSaved(pythonCode: String) {
        print("Receiving pythonCode = \(pythonCode)")
    }

    public func onXMLProgramSaved(xmlCode: String) {
        print("Receiving xmlCode = \(xmlCode)")
    }
}
