//
//  NibLoadable.swift
//  RevolutionRobotics
//
//  Created by Mate Papp on 2019. 04. 01..
//  Copyright © 2019. Revolution Robotics. All rights reserved.
//

protocol NibLoadable: AnyObject {
    static var nibName: String { get }
}
