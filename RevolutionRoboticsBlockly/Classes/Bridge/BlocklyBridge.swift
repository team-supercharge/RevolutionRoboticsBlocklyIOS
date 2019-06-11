//
//  BlocklyPromptBridge.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 05. 22..
//

public protocol BlocklyBridgeDelegate: class {
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
}

class BlocklyBridge {
    weak var delegate: BlocklyBridgeDelegate?

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

        case let type where type.contains(BlockType.variable):
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

    private func decodeJSONFromString<T: Decodable>(_ type: T.Type, string: String) -> T? {
        let decoder = JSONDecoder()
        guard let data = string.data(using: .utf8) else { return nil }

        return try? decoder.decode(T.self, from: data)
    }
}
