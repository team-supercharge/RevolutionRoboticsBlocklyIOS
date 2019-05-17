//
//  BlockContextAction.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 05. 20..
//

// MARK: BlockContextActionType
public enum BlockContextActionType: String, Encodable {
    case addComment = "ADD_COMMENT"
    case removeComment = "REMOVE_COMMENT"
    case deleteBlock = "DELETE_BLOCK"
    case help = "HELP"
    case duplicateBlock = "DUPLICATE_BLOCK"
};

// MARK: - BlockContextAction
public protocol BlockContextAction: Encodable {
    var type: BlockContextActionType { get }
}

public extension BlockContextAction {
    var jsonSerialized: String? {
        let jsonEncoder = JSONEncoder()
        guard let encodedAction = try? jsonEncoder.encode(self),
            let jsonString = String(data: encodedAction, encoding: .utf8) else {
                return nil
        }

        return jsonString
    }
}

public struct AddCommentAction: BlockContextAction {
    public var type: BlockContextActionType = .addComment
    public var payload: String

    public init(payload: String) {
        self.payload = payload
    }
}

public struct RemoveCommentAction: BlockContextAction {
    public var type: BlockContextActionType = .removeComment
}

public struct DeleteBlockAction: BlockContextAction {
    public var type: BlockContextActionType = .deleteBlock
}

public struct DuplicateBlockAction: BlockContextAction {
    public var type: BlockContextActionType = .duplicateBlock
}

public struct HelpAction: BlockContextAction {
    public var type: BlockContextActionType = .help
}
