//
//  PaperPlateScene.swift
//  TVOSBasics
//
//  Created by Paloma Bispo on 08/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import SceneKit

class PaperPlateScene: SCNScene {
    
    var state = FLGameState.redInitial
    
    weak var delegate: BallFlowSceneDelegate?
    
    lazy var cameraNode: SCNNode = {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 10, z: 17)
        cameraNode.camera?.fieldOfView = 90
        let rad = -50 * Float.pi / 180
        cameraNode.eulerAngles = SCNVector3Make(rad, 0, 0)
        
        return cameraNode
    }()
    
    lazy var lightNode: SCNNode = {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.light?.intensity = 1500
        lightNode.position = SCNVector3(x: 0, y: 20, z: 0)
        
        return lightNode
    }()
    
    lazy var straw: SCNNode = {
        let tube = SCNTube(innerRadius: 0.25, outerRadius: 0.5, height: 5.0)
        let strawNode = SCNNode(geometry: tube)
        strawNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        strawNode.position = SCNVector3(x: 0.0, y: -2.5, z: 12)
        strawNode.eulerAngles = SCNVector3Make(-80, 0, 0);
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "Assets.xcassets/texturaCanudo")
        tube.materials = [material]
        
        return strawNode
    }()
    
//    lazy var plate: SCNNode = {
//        let plate = SCNPlane()
//        let plateNode = SCNNode(geometry: plate)
//        plateNode.phy
//        
//        return plateNode
//    }()
    
    lazy var tableNode: SCNNode = {
        let table = TableNode()
        let xScale = table.scale.x
        let yScale = table.scale.y
        let zScale = table.scale.z
        table.scale = SCNVector3(x: xScale, y: yScale, z: zScale * 1.5 )
        table.position.y -= 4
        return table
    }()
    
    override init() {
        super.init()
        rootNode.addChildNode(cameraNode)
        rootNode.addChildNode(straw)
        rootNode.addChildNode(lightNode)
        rootNode.addChildNode(tableNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
