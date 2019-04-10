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

    private lazy var flowBallViewController = BallFlowViewController.init()
    private lazy var menuViewController = MenuViewController()
    
    func show(controllerType: ViewControllerType) {
        switch controllerType {
        case .flowBall:
            show(controller: flowBallViewController)
        case .howAmI:
            show(controller: menuViewController)
        }
    }
    
    func show(controller: UIViewController) {
        guard let appDelegate = UIApplication.shared.delegate else {
            return
        }
        
        appDelegate.window??.rootViewController = controller
    }
}
