//
//  VariableContextAction.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 06. 06..
//

public enum VariableContextActionType: String, Encodable {
    case setVariable = "SET_VARIABLE_ID"
    case deleteVariable = "DELETE_VARIABLE_ID"
}

public protocol VariableContextAction: JSONSerializableAction {
    var type: VariableContextActionType { get }
    var payload: String { get }

    init(payload: String)
}

public struct SetVariableAction: VariableContextAction {
    public var type: VariableContextActionType = .setVariable
    public var payload: String

    public init(payload: String) {
        self.payload = payload
    }
}

public struct DeleteVariableAction: VariableContextAction {
    public var type: VariableContextActionType = .deleteVariable
    public var payload: String

    public init(payload: String) {
        self.payload = payload
    }
}
