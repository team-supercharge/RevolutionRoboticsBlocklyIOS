// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RevolutionRoboticsBlockly",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "RevolutionRoboticsBlockly",
            targets: ["RevolutionRoboticsBlockly"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Lision/WKWebViewJavascriptBridge.git",
                 revision: "51cdc110657e5ad469df712ca79632761d3fe11d"),
    ],
    targets: [
        .target(
            name: "RevolutionRoboticsBlockly",
            dependencies: [
                "WKWebViewJavascriptBridge"
            ],
            path: "RevolutionRoboticsBlockly/Classes",
            resources: [
                .copy("Blockly/blockly_compressed.js"),
                .copy("Blockly/blocks_compressed.js"),
                .copy("Blockly/desktop.html"),
                .copy("Blockly/filesaver.js"),
                .copy("Blockly/media"),
                .copy("Blockly/msg"),
                .copy("Blockly/prism.css"),
                .copy("Blockly/prism.js"),
                .copy("Blockly/python_compressed.js"),
                .copy("Blockly/style.css"),
                .copy("Blockly/toolbox"),
                .copy("Blockly/toolbox_standard.js"),
                .copy("Blockly/webview.html"),
            ]),
    ]
)
