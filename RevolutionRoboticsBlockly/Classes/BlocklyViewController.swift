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

    // MARK: - Constant
    private enum Constant {
        static let hostHTML = "Blockly/webview.html"
    }

    public init() {
        super.init(nibName: type(of: self).nibName, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        loadWebContent()
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

// MAKR: - WKUIDelegate
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
        let closeAndHandle: Callback<Bool> = {
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
        let alert = UIAlertController(title: prompt, message: nil, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = defaultText
        }

        let okTitle = NSLocalizedString("OK", comment: "OK button title")
        let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
            let textInput = alert.textFields![0] as UITextField
            completionHandler(textInput.text)
        }
        alert.addAction(okAction)

        let cancelTitle = NSLocalizedString("Cancel", comment: "Cancel button title")
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (_) in
            completionHandler(nil)
        }
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
}
