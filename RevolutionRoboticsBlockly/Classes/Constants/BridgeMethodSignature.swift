//
//  BridgeMethodSignature.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 04. 17..
//

enum BridgeMethodSignature {
    static let loadXMLProgram = "NativeBridge.loadXMLProgram"
    static let saveProgram = "NativeBridge.saveProgram"
    static let clearWorkspace = "NativeBridge.clearWorkspace"
    static let onXMLProgramSaved = "NativeBridge.onXMLProgramSaved"
    static let onPythonProgramSaved = "NativeBridge.onPythonProgramSaved"
    static let onVariablesExported = "NativeBridge.onVariablesExported"
}
