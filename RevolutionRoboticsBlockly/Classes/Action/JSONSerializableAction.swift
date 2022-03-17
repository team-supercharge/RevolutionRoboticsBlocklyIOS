//
//  Action.swift
//  Pods-RevolutionRoboticsBlockly_Example
//
//  Created by Mate Papp on 2019. 06. 06..
//

import Foundation

public protocol JSONSerializableAction: Encodable { }

public extension JSONSerializableAction {
    var jsonSerialized: String? {
        let jsonEncoder = JSONEncoder()
        guard let encodedAction = try? jsonEncoder.encode(self),
            let jsonString = String(data: encodedAction, encoding: .utf8) else {
                return nil
        }

        return jsonString
    }
}
