//
//  UIVelocitySwipeGestureRecognizer.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit
import SceneKit


/// a swipe regognizer that returns a 3D world force using the velocity of pan gesture
class ForceSwipeGestureRecognizer: UIPanGestureRecognizer {

    var forceFactor: CGFloat
    
    init(target: Any?, action: Selector?, forceFactor: CGFloat) {
        self.forceFactor = forceFactor
        
        super.init(target: target, action: action)
    }
    
    func force(in view: UIView?) -> SCNVector3 {
        let panVelocity = self.velocity(in: view)
        
        let movingForceVector = SCNVector3.init(panVelocity.x/forceFactor, 0, panVelocity.y/forceFactor)
        
        return movingForceVector
    }
}
