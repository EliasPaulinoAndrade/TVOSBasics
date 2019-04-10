//
//  PPPlateNode.swift
//  TVOSBasics
//
//  Created by Paloma Bispo on 09/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import SceneKit

class PPPlateNode: SCNNode {
    
    var plateNode: SCNNode? = SCNScene.loadSceneNode(sceneName: "plate.scn", nodeName: "plate")
    
    var points: Int?
    
    override init() {
        super.init()
 
        let plateGeometry = SCNCylinder(radius: 3.559 / 2.0, height: 0.327)
//        geometry = plateGeometry
        
        position = SCNVector3.zero
        position.y = 2.4
        
        let shape = SCNPhysicsShape.init(geometry: plateGeometry, options: nil)
        
        physicsBody = SCNPhysicsBody.init(type: .dynamic, shape: shape)
        physicsBody?.isAffectedByGravity = false
        self.eulerAngles = SCNVector3(Float.pi / 2, 0, 0)
        
        if let plateNode = plateNode {
            plateNode.position.z = -0.012
            plateNode.position.y = -0.181
            addChildNode(plateNode)
        }
        
        willCollideWith(nodeTypes: [
            BallNode.self,
            PPPlateNode.self,
            TableNode.self
            ])
        willContactWith(nodeTypes: [
            TableNode.self
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
