//
//  FLBallNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

/// the ball controlled by the user
class FLBallNode: SCNNode {
    
    var wasUsed = false
    
    init(withRadius radius: CGFloat) {
        super.init()
        
        let ballGeometry = SCNSphere.init(radius: radius)
        geometry = ballGeometry
        
        position = SCNVector3.zero
        position.y = 3
        
        physicsBody = SCNPhysicsBody.init(type: .dynamic, shape: nil)
        
        willCollideWith(nodeTypes: [
            TableNode.self,
            FLBallsBoxNode.self,
            FLBallNode.self,
            FLHorsesShoeNode.self,
            FLObstacleNode.self
        ])
        willContactWith(nodeTypes: [
            FLTargetPointNode.self,
            FLTableLimitsNode.self
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
