//
//  BlockContextAction.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 05. 20..
//

public enum BlockContextActionType: String, Encodable {
    case addComment = "ADD_COMMENT"
    case deleteBlock = "DELETE_BLOCK"
    case help = "HELP"
    case duplicateBlock = "DUPLICATE_BLOCK"
};

public protocol BlockContextAction: JSONSerializableAction {
    var type: BlockContextActionType { get }
}

public struct AddCommentAction: BlockContextAction {
    public var type: BlockContextActionType = .addComment
    public var payload: String?

    public init(payload: String?) {
        self.payload = payload
    }
}

public struct DeleteBlockAction: BlockContextAction {
    public var type: BlockContextActionType = .deleteBlock

    public init() { }
}

public struct DuplicateBlockAction: BlockContextAction {
    public var type: BlockContextActionType = .duplicateBlock

    public init() { }
}

public struct HelpAction: BlockContextAction {
    public var type: BlockContextActionType = .help

    public init() { }
}
