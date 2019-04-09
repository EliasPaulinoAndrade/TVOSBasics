//
//  PPTableLimits.swift
//  TVOSBasics
//
//  Created by Paloma Bispo on 08/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import SceneKit

class PPTableLimits: SCNNode {
    
    let leftNode = SCNNode()
    let rightNode = SCNNode()
    let backNode = SCNNode()

    override init() {
        super.init()
        
        let left = SCNPlane(width: 40, height: 30)
        let right = SCNPlane(width: 40, height: 30)
        let back = SCNPlane(width: 40, height: 30)
        
        back.materials.first?.transparency = 0
        right.materials.first?.transparency = 0
        left.materials.first?.transparency = 0
        
        leftNode.geometry = left
        rightNode.geometry = left
        backNode.geometry = left
        
        leftNode.name = "left"
        rightNode.name = "right"
        backNode.name = "back"
        self.name = "limits"
        
        leftNode.position = SCNVector3(-20, 0, 5)
        rightNode.position = SCNVector3(20, 0, 5)
        backNode.position = SCNVector3(0, 0, -10)
        
        let radLeft = 90 * Float.pi / 180
        let radRight = -90 * Float.pi / 180
        
        leftNode.eulerAngles = SCNVector3(x: 0, y: radLeft, z: 0)
        rightNode.eulerAngles = SCNVector3(x: 0, y: radRight, z: 0)
    
        addChildNodes([backNode, leftNode, rightNode])
        self.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        
        
        back.materials.first?.transparency = 0
        left.materials.first?.transparency = 0
        right.materials.first?.transparency = 0
        
        willCollideWith(nodeTypes: [])
        willContactWith(nodeTypes: [BallNode.self])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
