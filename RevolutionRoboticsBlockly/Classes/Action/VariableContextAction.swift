//
//  VariableContextAction.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 06. 06..
//

public enum VariableContextActionType: String, ActionType {
    case setVariable = "SET_VARIABLE_ID"
    case deleteVariable = "DELETE_VARIABLE_ID"
}

public struct SetVariableAction: Action {
    public var type: VariableContextActionType = .setVariable
    public var payload: String

    public init(payload: String) {
        self.payload = payload
    }
}

public struct DeleteVariableAction: Action {
    public var type: VariableContextActionType = .deleteVariable
    public var payload: String

    public init(payload: String) {
        self.payload = payload
    }
}
