//
//  FLTableNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

/// the table of the game
class FLTableNode: SCNNode {
    
    var tableNode: SCNNode? = SCNScene.loadSceneNode(sceneName: "table.scn", nodeName: "table")
    
    override init() {
        super.init()
        
        let tableGeometry = SCNBox.init(width: 28.85454, height: 1, length: 13.806, chamferRadius: 0)
        
        geometry = tableGeometry
        position = SCNVector3.zero
        physicsBody = SCNPhysicsBody.init(type: .static, shape: nil)
        
        if let tableNode = tableNode {
            addChildNode(tableNode)
        }
        
        willCollideWith(nodeTypes: [FLBallNode.self])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
