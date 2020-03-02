//
//  BlockType.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 06. 02..
//

enum BlockType {
    static let math = "math_number"
    static let playTune = "play_tune"
    static let colour = "colour_picker"
    static let logicBoolean = "logic_boolean"
    static let variable = "variable"
    static let variableContext = ".var"
    static let blockContext = "block_context"
    static let selector = "selector"
    static let input = "input"
    static let slider = "slider"
    static let procedures = "procedures"
    static let singleLEDSelector = "block_set_led.led"
    static let allLEDSelector = "block_set_all_leds.color"
    static let multiLEDSelector = "block_set_multiple_led.led_ids"
    static let driveDirectionSelector = "block_drive.direction_selector"
    static let motorSelector = "motor.name_input"
    static let motorSimplifiedSelector = "motor_simplified.name_input"
    static let motorReadPosition = "block_read_motor_position.name_input"
    static let motorResetPosition = "block_reset_motor_position.name_input"
    static let bumperSelector = "bumper.name_input"
    static let sensorSelector = "sensor.name_input"
    static let objectNearSelector = "block_is_object_near.name_input"
    static let loopCountSelector = "controls_repeat_n_times"
    static let waitSelector = "block_wait_simplified"
}
