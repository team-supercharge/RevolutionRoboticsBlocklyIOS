//
//  BlocklyPromptBridge.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 05. 22..
//

public protocol BlocklyBridgeDelegate: class {
    func singleOptionSelector(_ optionSelector: SingleOptionSelector, callback: ((String?) -> Void)?)
    func multiOptionSelector(_ optionSelector: MultiOptionSelector, callback: ((String?) -> Void)?)
    func colorSelector(_ optionSelector: SingleOptionSelector, callback: ((String?) -> Void)?)
    func audioSelector(_ optionSelector: SingleOptionSelector, callback: ((String?) -> Void)?)
    func numberInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?)
    func textInput(_ inputHandler: InputHandler, callback: ((String?) -> Void)?)
    func blockContext(_ contextHandler: BlockContextHandler, callback: ((BlockContextAction?) -> Void)?)
}

class BlocklyBridge {
    weak var delegate: BlocklyBridgeDelegate?

    func handlePrompt(type: String, data: String, callback: ((String?) -> Void)?) {
        switch type {
        case let type where type.contains(BlockType.math):
            guard let inputHandler = decodeJSONFromString(InputHandler.self, string: data) else {
                return
            }

            delegate?.numberInput(inputHandler, callback: callback)

        case let type where type.contains(BlockType.playTune):
            guard let optionSelector = decodeJSONFromString(SingleOptionSelector.self, string: data) else {
                return
            }

            delegate?.audioSelector(optionSelector, callback: callback)

        case let type where type.contains(BlockType.colour):
            guard let optionSelector = decodeJSONFromString(SingleOptionSelector.self, string: data) else {
                return
            }

            delegate?.colorSelector(optionSelector, callback: callback)

        case let type where type.contains(BlockType.logicBoolean):
            guard let optionSelector = decodeJSONFromString(SingleOptionSelector.self, string: data) else {
                return
            }

            delegate?.singleOptionSelector(optionSelector, callback: callback)

        case let type where type.contains(BlockType.selector):
            guard let optionSelector = decodeJSONFromString(SingleOptionSelector.self, string: data) else {
                return
            }

            delegate?.singleOptionSelector(optionSelector, callback: callback)

        case let type where type.contains(BlockType.input):
            guard let inputHandler = decodeJSONFromString(InputHandler.self, string: data) else {
                return
            }

            delegate?.textInput(inputHandler, callback: callback)

        case let type where type.contains(BlockType.variable):
            guard let inputHandler = decodeJSONFromString(InputHandler.self, string: data) else {
                return
            }

            delegate?.textInput(inputHandler, callback: callback)

        case let type where type.contains(BlockType.blockContext):
            guard let contextHandler = decodeJSONFromString(BlockContextHandler.self, string: data) else {
                return
            }

            delegate?.blockContext(contextHandler) { action in
                callback?(action?.jsonSerialized)
            }

        default:
            callback?(nil)
        }
    }

    private func decodeJSONFromString<T: Decodable>(_ type: T.Type, string: String) -> T? {
        let decoder = JSONDecoder()
        guard let data = string.data(using: .utf8) else { return nil }

        return try? decoder.decode(T.self, from: data)
    }
}
