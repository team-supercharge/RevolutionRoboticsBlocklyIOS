//
//  OptionSelector.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 05. 22..
//

public struct OptionSelector: Decodable {
    public var options: [Option]
    public var defaultKey: String
    public var title: String?
}
