//
//  BlocklyPromptBridge.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 05. 22..
//

import WebKit
import WKWebViewJavascriptBridge

// MARK: - BlocklyBridgeDelegate
public protocol BlocklyBridgeDelegate: class {
    func alert(message: String, callback: (() -> Void)?)
    func confirm(message: String, callback: ((Bool) -> Void)?)
    func optionSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?)
    func driveDirectionSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?)
    func colorSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?)
    func audioSelector(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?)
    func sliderHandler(_ sliderHandler: SliderHandler, callback: ((String?) -> Void)?)
    func singleLEDInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?)
    func multiLEDInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?)
    func numberInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?)
    func textInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?)
    func variableContext(_ optionSelector: OptionSelector, callback: ((String?) -> Void)?)
    func blockContext(_ contextHandler: BlockContextHandler, callback: ((String?) -> Void)?)
    func onBlocklyLoaded()
    func onVariablesExported(variables: String)
    func onPythonProgramSaved(pythonCode: String)
    func onXMLProgramSaved(xmlCode: String)
}

// MARK: - BlocklyBridge
class BlocklyBridge {
    // MARK: - Properties
    private var bridge: WKWebViewJavascriptBridge?
    weak var delegate: BlocklyBridgeDelegate?

    // MARK: - Setup
    func connectBridge(with webView: WKWebView) {
        bridge = WKWebViewJavascriptBridge(webView: webView)
        registerHandlers()
    }
}

// MARK: - Events
extension BlocklyBridge {
    func onWebViewLoaded() {
        delegate?.onBlocklyLoaded()
    }
}

// MARK: - iOS -> Javascript
extension BlocklyBridge {
    func loadProgram(xml: String) {
        bridge?.call(handlerName: BridgeMethodSignature.loadXMLProgram, data: xml)
    }

    func saveProgram() {
        bridge?.call(handlerName: BridgeMethodSignature.saveProgram)
    }

    func clearWorkspace() {
        bridge?.call(handlerName: BridgeMethodSignature.clearWorkspace)
    }
}

// MARK: - Javascript -> iOS
extension BlocklyBridge {
    private func registerHandlers() {
        bridge?.register(handlerName: BridgeMethodSignature.onPythonProgramSaved) { [weak self] (parameters, _) in
            guard let dict = parameters, let pythonCode = self?.decodeResponseParameter(dictionary: dict) else { return }
            self?.delegate?.onPythonProgramSaved(pythonCode: pythonCode)
        }

        bridge?.register(handlerName: BridgeMethodSignature.onXMLProgramSaved) { [weak self] (parameters, _) in
            guard let dict = parameters, let xmlCode = self?.decodeResponseParameter(dictionary: dict) else { return }
            self?.delegate?.onXMLProgramSaved(xmlCode: xmlCode)
        }

        bridge?.register(handlerName: BridgeMethodSignature.onVariablesExported) { [weak self] (parameters, _) in
            guard let dict = parameters, let variables = self?.decodeResponseParameter(dictionary: dict) else { return }
            self?.delegate?.onVariablesExported(variables: variables)
        }
    }
}

// MARK: - Handling alert, confirm, prompt
extension BlocklyBridge {
    func handleAlert(message: String, callback: (() -> Void)?) {
        delegate?.alert(message: message, callback: callback)
    }

    func handleConfirm(message: String, callback: ((Bool) -> Void)?) {
        delegate?.confirm(message: message, callback: callback)
    }

    func handlePrompt(type: String, data: String, callback: ((String?) -> Void)?) {
        switch type {
        case let type where type.contains(BlockType.singleLEDSelector):
            guard let inputHandler = decodeJSONFromString(InputHandler.self, string: data) else {
                return
            }

            delegate?.singleLEDInput(inputHandler, callback: callback)

        case let type where type.contains(BlockType.multiLEDSelector):
            guard let inputHandler = decodeJSONFromString(InputHandler.self, string: data) else {
                return
            }

            delegate?.multiLEDInput(inputHandler, callback: callback)

        case let type where type.contains(BlockType.slider):
            guard let sliderHandler = decodeJSONFromString(SliderHandler.self, string: data) else {
                return
            }

            delegate?.sliderHandler(sliderHandler, callback: callback)

        case let type where type.contains(BlockType.playTune):
            guard let optionSelector = decodeJSONFromString(OptionSelector.self, string: data) else {
                return
            }

            delegate?.audioSelector(optionSelector, callback: callback)

        case let type where type.contains(BlockType.colour):
            guard let optionSelector = decodeJSONFromString(OptionSelector.self, string: data) else {
                return
            }

            delegate?.colorSelector(optionSelector, callback: callback)

        case let type where type.contains(BlockType.logicBoolean):
            guard let optionSelector = decodeJSONFromString(OptionSelector.self, string: data) else {
                return
            }

            delegate?.optionSelector(optionSelector, callback: callback)

        case let type where type.contains(BlockType.driveDirectionSelector):
            guard let optionSelector = decodeJSONFromString(OptionSelector.self, string: data) else {
                return
            }

            delegate?.driveDirectionSelector(optionSelector, callback: callback)

        case let type where type.contains(BlockType.selector):
            guard let optionSelector = decodeJSONFromString(OptionSelector.self, string: data) else {
                return
            }

            delegate?.optionSelector(optionSelector, callback: callback)

        case let type where type.contains(BlockType.input):
            guard let inputHandler = decodeJSONFromString(InputHandler.self, string: data) else {
                return
            }

            delegate?.textInput(inputHandler, callback: callback)

        case let type where type.contains(BlockType.variableContext):
            guard let optionSelector = decodeJSONFromString(OptionSelector.self, string: data) else {
                return
            }

            delegate?.variableContext(optionSelector, callback: callback)

        case let type where type == BlockType.variable:
            guard let inputHandler = decodeJSONFromString(InputHandler.self, string: data) else {
                return
            }

            delegate?.textInput(inputHandler, callback: callback)

        case let type where type.contains(BlockType.blockContext):
            guard let contextHandler = decodeJSONFromString(BlockContextHandler.self, string: data) else {
                return
            }

            delegate?.blockContext(contextHandler, callback: callback)

        case let type where type.contains(BlockType.math):
            guard let inputHandler = decodeJSONFromString(InputHandler.self, string: data) else {
                return
            }

            delegate?.numberInput(inputHandler, callback: callback)

        default:
            callback?(nil)
        }
    }
}

// MARK: - Helper
extension BlocklyBridge {
    private func decodeJSONFromString<T: Decodable>(_ type: T.Type, string: String) -> T? {
        let decoder = JSONDecoder()
        guard let data = string.data(using: .utf8) else { return nil }

        return try? decoder.decode(T.self, from: data)
    }

    private func decodeResponseParameter(dictionary: [String: Any]) -> String? {
        return dictionary["parameter"] as? String
    }
}
