//
//  BlockContextAction.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 05. 20..
//

public enum BlockContextActionType: String, ActionType {
    case addComment = "ADD_COMMENT"
    case deleteBlock = "DELETE_BLOCK"
    case help = "HELP"
    case duplicateBlock = "DUPLICATE_BLOCK"
};

public struct AddCommentAction: Action {
    public var type: BlockContextActionType = .addComment
    public var payload: String

    public init(payload: String) {
        self.payload = payload
    }
}

public struct DeleteBlockAction: Action {
    public var type: BlockContextActionType = .deleteBlock
    public var payload: String

    public init(payload: String) {
        self.payload = payload
    }
}

public struct DuplicateBlockAction: Action {
    public var type: BlockContextActionType = .duplicateBlock
    public var payload: String

    public init(payload: String) {
        self.payload = payload
    }
}

public struct HelpAction: Action {
    public var type: BlockContextActionType = .help
    public var payload: String

    public init(payload: String) {
        self.payload = payload
    }
}
