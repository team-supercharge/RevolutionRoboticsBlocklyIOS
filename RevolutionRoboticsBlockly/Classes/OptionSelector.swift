//
//  OptionSelector.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 05. 22..
//

public struct SingleOptionSelector: Decodable {
    public var options: [Option]
    public var defaultKey: String
    public var title: String?
}

public struct MultiOptionSelector: Decodable {
    public var options: [Option]
    public var defaultKeys: [String]
    public var title: String?
}
