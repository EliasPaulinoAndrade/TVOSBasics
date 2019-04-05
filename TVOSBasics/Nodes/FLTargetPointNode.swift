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
    }
    
    init(zPosition: Float) {
        super.init()
        
        let targetPointGeometry = SCNCylinder.init(radius: 1, height: 0.05)
        
        geometry = targetPointGeometry
        position = SCNVector3.zero
        position.x = 11.5
        position.y += 0.5
        position.z = zPosition
        
        physicsBody = SCNPhysicsBody.init(type: .kinematic, shape: nil)
        
        willContactWith(nodeTypes: [FLBallNode.self])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
