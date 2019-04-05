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
    
    var horsesShoeNode: SCNNode? = SCNScene.loadSceneNode(sceneName: "horseshoe2.scn", nodeName: "horseshoe")
    
    override init() {
        super.init()
        
        position = SCNVector3.zero
        position.y = 0.1
        
        if let horsesShoeNode = horsesShoeNode,
           let horsesShoeGeometry = horsesShoeNode.geometry {
            addChildNode(horsesShoeNode)
            
            let scale = SCNVector3.init(1.4, 1.4, 1.4)
            
            let shapeBody = SCNPhysicsShape.init(geometry: horsesShoeGeometry, options: [
                SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.concavePolyhedron,
                SCNPhysicsShape.Option.scale: scale
            ])
            
            self.eulerAngles.y = Float.pi
            self.eulerAngles.z = Float.pi
            self.scale = scale
            
            physicsBody = SCNPhysicsBody.init(type: .kinematic, shape: shapeBody)
        }
        
        willCollideWith(nodeTypes: [FLBallNode.self])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
