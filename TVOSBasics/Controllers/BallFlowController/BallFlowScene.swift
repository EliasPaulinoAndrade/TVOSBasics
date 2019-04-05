//
//  BallFlowScene.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

class BallFlowScene: SCNScene {
    
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
        lightNode.position = SCNVector3(x: 0, y: 10, z: 0)
        
        return lightNode
    }()
    
    lazy var tableNode = FLTableNode.init()
    
    lazy var ballNode = FLBallNode.init()
    
    lazy var firstTargetPointNode = FLTargetPointNode.init(zPosition: 0)
    
    lazy var secondTargetPointNode = FLTargetPointNode.init(zPosition: 5)
    
    lazy var thirdTargetPointNode = FLTargetPointNode.init(zPosition: -5)
    
    override init() {
        super.init()
        
        rootNode.addChildNode(cameraNode)
        rootNode.addChildNode(lightNode)
        rootNode.addChildNode(tableNode)
        rootNode.addChildNode(ballNode)
        tableNode.addChildNode(firstTargetPointNode)
        tableNode.addChildNode(secondTargetPointNode)
        tableNode.addChildNode(thirdTargetPointNode)
        
        self.physicsWorld.contactDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotateTable() {
        
        tableNode.runAction(SCNAction.rotateBy(x: 0.1, y: 0, z: 0, duration: 1))
    }
    
    func moveBall(withForce force: SCNVector3) {
        ballNode.physicsBody?.applyForce(force, asImpulse: true)
    }
}

extension BallFlowScene: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        
    }
}
