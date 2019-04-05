//
//  FLTableNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

class FLTableNode: SCNNode {
    override init() {
        super.init()
        
        let tableGeometry = SCNBox.init(width: 25, height: 1, length: 12, chamferRadius: 0)
        
        geometry = tableGeometry
        position = SCNVector3.zero
        physicsBody = SCNPhysicsBody.init(type: .static, shape: nil)
        
        registerCategoryMask()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
