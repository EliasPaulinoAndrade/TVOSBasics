//
//  FLObstacleNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

class FLObstacleNode: SCNNode {
    
    var obstacleNode: SCNNode? = SCNScene.loadSceneNode(sceneName: "obstacle.scn", nodeName: "obstacle")
    
    override init() {
        super.init()
        
        position = SCNVector3.zero
        position.y = 1.889
        
        if let obstacleNode = obstacleNode,
            let obstacleNodeGeometry = obstacleNode.geometry {
//            addChildNode(obstacleNode)
            
            geometry = obstacleNodeGeometry
//            let scale = SCNVector3.init(1.4, 1.4, 1.4)
            
//            let shapeBody = SCNPhysicsShape.init(geometry: obstacleNodeGeometry, options: [
//                SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.concavePolyhedron
//            ])
//
////            self.eulerAngles.y = Float.pi
//            self.eulerAngles.z = Float.pi
//            self.scale = scale
            
            self.scale = obstacleNode.scale
            self.rotation = obstacleNode.rotation
            
            physicsBody = SCNPhysicsBody.init(type: .kinematic, shape: nil)
        }
        
        willCollideWith(nodeTypes: [FLBallNode.self])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
