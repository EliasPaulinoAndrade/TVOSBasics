//
//  FLTableLimitsNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

/// a giant box arround the scenario used to detect when a ball leaves the scene
class FLTableLimitsNode: SCNNode {
    override init() {
        super.init()
        
        let tableGeometry = SCNBox.init(width: 35, height: 20, length: 20, chamferRadius: 0)
        tableGeometry.materials.first?.transparency = 0
        
        geometry = tableGeometry
        position = SCNVector3.zero
        
        let tableShape = SCNPhysicsShape.init(
            geometry: tableGeometry,
            options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.concavePolyhedron]
        )
        
        physicsBody = SCNPhysicsBody.init(type: .kinematic, shape: tableShape)
        
        willCollideWith(nodeTypes: [])
        willContactWith(nodeTypes: [FLBallNode.self])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
