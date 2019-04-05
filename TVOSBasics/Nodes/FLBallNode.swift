//
//  FLBallNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

class FLBallNode: SCNNode {
    override init() {
        super.init()
        
        let ballGeometry = SCNSphere.init(radius: 0.5)
        geometry = ballGeometry
        
        position = SCNVector3.zero
        position.y = 3
        
        physicsBody = SCNPhysicsBody.init(type: .dynamic, shape: nil)
        
        willCollideWith(nodeTypes: [FLTableNode.self])
        willContactWith(nodeTypes: [FLTargetPointNode.self])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
