//
//  AudioHandlerBridge.swift
//  RevolutionRoboticsBlockly
//
//  Created by Mate Papp on 2019. 04. 12..
//

import Foundation
import AVFoundation
import WebKit
import WKWebViewJavascriptBridge

final class AudioHandlerBridge {
    private var player: AVAudioPlayer?
    private var bridge: WKWebViewJavascriptBridge?

    func setupJavascriptBridge(in webView: WKWebView) {
        bridge = WKWebViewJavascriptBridge(webView: webView)
        bridge?.register(handlerName: BridgeMethodSignature.playSound.rawValue) { [weak self] (parameters, _) in
            guard let fileName = parameters?.values.first as? String else { return }
            self?.playSound(file: fileName)
        }
    }

    private func playSound(file: String) {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: file, withExtension: "mp3") else {
            print("Couldn't find \(file) in boundle")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
