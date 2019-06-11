//
//  Action.swift
//  Pods-RevolutionRoboticsBlockly_Example
//
//  Created by Mate Papp on 2019. 06. 06..
//

public protocol ActionType: Encodable { }

public protocol Action: Encodable {
    associatedtype AT = ActionType
    var type: AT { get }
    var payload: String { get }

    init(payload: String)
}

extension Action {
    var jsonSerialized: String? {
        let jsonEncoder = JSONEncoder()
        guard let encodedAction = try? jsonEncoder.encode(self),
            let jsonString = String(data: encodedAction, encoding: .utf8) else {
                return nil
        }

        return jsonString
    }
}
