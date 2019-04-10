//
//  ViewController.swift
//  RevolutionRoboticsBlockly
//
//  Created by Gabor Nagy Farkas on 04/10/2019.
//  Copyright (c) 2019 Gabor Nagy Farkas. All rights reserved.
//

import UIKit
import RevolutionRoboticsBlockly

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func blocklyButtonTapped(_ sender: Any) {
        navigationController?.pushViewController(BlocklyViewController(), animated: true)
    }
}
