//
//  BlocklyViewController.swift
//  RevolutionRobotics
//
//  Created by Mate Papp on 2019. 04. 03..
//  Copyright © 2019. Revolution Robotics. All rights reserved.
//

import UIKit
import WebKit

public class BlocklyViewController: UIViewController, NibLoadable {
    // MARK: - Outlet
    @IBOutlet weak var webView: WKWebView!

    // MARK: - Properties
    private let blocklyBridge = BlocklyBridge()

    // MARK: - Constant
    private enum Constant {
        static let webview: (resource: String, extension: String) = (resource: "webview", extension: "html")
        static let iOSBlocklyUserAgent = "iOS-Blockly"
    }

    // MARK: - Init
    public init() {
        super.init(nibName: type(of: self).nibName, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadWebContent()
        setupBridge()
    }
}

// MARK: - Setup
extension BlocklyViewController {
    private func setupWebView() {
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.bounces = false
        webView.customUserAgent = Constant.iOSBlocklyUserAgent
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }

    private func loadWebContent() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: Constant.webview.resource, withExtension: Constant.webview.extension) else {
            print("Failed to load HTML. Could not find resource.")
            return
        }

        webView.load(URLRequest(url: url))
    }

    private func setupBridge() {
        blocklyBridge.connectBridge(with: webView)
    }
}

// MARK: - Public
public extension BlocklyViewController {
    func setup(blocklyBridgeDelegate: BlocklyBridgeDelegate?) {
        blocklyBridge.delegate = blocklyBridgeDelegate
    }

    func loadProgram(xml: String) {
        blocklyBridge.loadProgram(xml: xml)
    }

    func saveProgram() {
        blocklyBridge.saveProgram()
    }

    func clearWorkspace() {
        blocklyBridge.clearWorkspace()
    }
}

// MARK: - WKUIDelegate
extension BlocklyViewController: WKUIDelegate {
    // MARK: - window.alert()
    public func webView(
        _ webView: WKWebView,
        runJavaScriptAlertPanelWithMessage message: String,
        initiatedByFrame frame: WKFrameInfo,
        completionHandler: @escaping () -> Void
    ) {
        blocklyBridge.handleAlert(message: message, callback: completionHandler)
    }

    // MARK: - window.confirm()
    public func webView(
        _ webView: WKWebView,
        runJavaScriptConfirmPanelWithMessage message: String,
        initiatedByFrame frame: WKFrameInfo,
        completionHandler: @escaping (Bool) -> Void
    ) {
        blocklyBridge.handleConfirm(message: message, callback: completionHandler)
    }

    // MARK: - window.prompt()
    public func webView(
        _ webView: WKWebView,
        runJavaScriptTextInputPanelWithPrompt prompt: String,
        defaultText: String?,
        initiatedByFrame frame: WKFrameInfo,
        completionHandler: @escaping (String?) -> Void
    ) {
        guard let defaultText = defaultText else { return }
        blocklyBridge.handlePrompt(type: prompt, data: defaultText, callback: completionHandler)
    }
}

extension BlocklyViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        blocklyBridge.onWebViewLoaded()
    }
}
