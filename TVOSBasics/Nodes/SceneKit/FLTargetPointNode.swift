//
//  FLTargetPointNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

class FLTargetPointNode: SCNNode {
    
    override init() {
        super.init()
        
        let targetPointGeometry = SCNCylinder.init(radius: 1, height: 0.05)
        geometry = targetPointGeometry

        physicsBody = SCNPhysicsBody.init(type: .kinematic, shape: nil)
        
        willContactWith(nodeTypes: [FLBallNode.self])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
