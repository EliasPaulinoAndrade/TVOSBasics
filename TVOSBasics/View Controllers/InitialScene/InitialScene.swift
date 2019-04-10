//
//  InitialScene.swift
//  TVOSBasics
//
//  Created by Cibele Paulino on 09/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

class initialScene: SCNScene{
    
    lazy var cameraNode: SCNNode = {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 13, z: 15)
        
        cameraNode.eulerAngles.x = -Float(Double.pi / 5)
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
    
    var testWalls = WallsBoxNode.init()
    
    override init() {
        super.init()
     
        rootNode.addChildNode(cameraNode)
        rootNode.addChildNode(lightNode)
        rootNode.addChildNode(testWalls)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
