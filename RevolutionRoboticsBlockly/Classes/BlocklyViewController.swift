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
        static let hostHTML = "Blockly/webview.html"
        static let iOSBlocklyUserAgent = "iOS-Blockly"
    }

    // MARK: - Init
    public init() {
        super.init(nibName: type(of: self).nibName, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadWebContent()
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
    }

    private func loadWebContent() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "webview", withExtension: "html")
        
        guard let htmlURL = url else {
            print("Failed to load HTML. Could not find resource.")
            return
        }
        
        webView.load(URLRequest(url: htmlURL))
    }
}

// MARK: - Public
public extension BlocklyViewController {
    func setup(blocklyBridgeDelegate: BlocklyBridgeDelegate?) {
        blocklyBridge.connectBridge(with: webView)
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
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let title = NSLocalizedString("OK", comment: "OK Button")
        let ok = UIAlertAction(title: title, style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true)
        completionHandler()
    }

    // MARK: - window.confirm()
    public func webView(
        _ webView: WKWebView,
        runJavaScriptConfirmPanelWithMessage message: String,
        initiatedByFrame frame: WKFrameInfo,
        completionHandler: @escaping (Bool) -> Void
    ) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let closeAndHandle: (Bool) -> Void = {
            alert.dismiss(animated: true, completion: nil)
            completionHandler($0)
        }

        let okTitle = NSLocalizedString("OK", comment: "OK button title")
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            closeAndHandle(true)
        }
        alert.addAction(ok)

        let cancelTitle = NSLocalizedString("Cancel", comment: "Cancel button title")
        let cancel = UIAlertAction(title: cancelTitle, style: .default) { _ in
            closeAndHandle(false)
        }
        alert.addAction(cancel)
        present(alert, animated: true)
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
