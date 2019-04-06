//
//  GamesNavigator.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit

class GamesNavigator {

    var flowBallViewController = BallFlowViewController.init()
    
    func show(controllerType: ViewControllerType) {
        switch controllerType {
        case .flowBall:
            show(controller: flowBallViewController)
        }
    }
    
    func show(controller: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate else {
            return
        }
        
        appDelegate.window??.rootViewController = controller
    }
}
