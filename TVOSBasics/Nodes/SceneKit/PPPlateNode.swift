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
    
    var points: Int?
    
    override init() {
        super.init()
        let plateGeometry = SCNPlane(width: 10, height: 10)
        plateGeometry.cornerRadius = 10
        geometry = plateGeometry
        
        position = SCNVector3.zero
        position.y = 3
        
        physicsBody = SCNPhysicsBody.init(type: .dynamic, shape: nil)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "texturaCanudo")
        plateGeometry.materials = [material]
        
        willCollideWith(nodeTypes: [
            BallNode.self
            ])
        willContactWith(nodeTypes: [
            TableNode.self
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
