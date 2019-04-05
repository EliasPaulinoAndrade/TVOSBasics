//
//  ViewController.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(teste(recognizer:)))
//        tapRecognizer.allowedPressTypes = []
        
//        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.select.rawValue)];
     
//        UIPress.PressType.
//    UIPress.PressType.
        button.addTarget(self, action: #selector(teste2(_:)), for: .primaryActionTriggered)
//        button.addGestureRecognizer(tapRecognizer)
    }

    @objc func teste2(_ sender: Any) {
        
    }
}


