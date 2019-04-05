//
//  FLHorsesShoeNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

class FLHorsesShoeNode: SCNNode {
    
    var horsesShoeNode: SCNNode? = SCNScene.loadSceneNode(sceneName: "horseshoe.scn", nodeName: "horseshoe")
    
    init(zPosition: Float) {
        super.init()
        
        position = SCNVector3.zero
        position.x = 11.5
        position.y += 0.5
        position.z = zPosition
        
        
        if let horsesShoeNode = horsesShoeNode {
            addChildNode(horsesShoeNode)
            horsesShoeNode.position.y = 2
        }
        
//        physicsBody = SCNPhysicsBody.init(type: .dynamic, shape: nil)
        
//        willCollideWith(nodeTypes: [FLTableNode.self, FLBallsBoxNode.self, FLBallNode.self])
//        willContactWith(nodeTypes: [FLTargetPointNode.self])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
