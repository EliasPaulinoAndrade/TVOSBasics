//
//  PPStrawNode.swift
//  TVOSBasics
//
//  Created by Paloma Bispo on 08/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import SceneKit

class PPStrawNode: SCNNode {
    
    override init() {
        super.init()
        let tube = SCNTube(innerRadius: 0.25, outerRadius: 0.5, height: 5.0)
        self.geometry = tube
        
        let shapeBody = SCNPhysicsShape.init(geometry: tube, options: [
            SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.concavePolyhedron
        ])
        
        self.physicsBody = SCNPhysicsBody(type: .static, shape: shapeBody)
        
        self.position = SCNVector3(x: 0.0, y: 2.0, z: 13)
        self.eulerAngles = SCNVector3Make(Float.pi/2, 0, 0);
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "texturaCanudo")
        tube.materials = [material]
        willCollideWith(nodeTypes: [BallNode.self])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
