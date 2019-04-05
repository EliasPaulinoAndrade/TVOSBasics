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
    
    var state = FLGameState.redInitial
    
    weak var delegate: BallFlowSceneDelegate?
    
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
    
    var tableNode = FLTableNode.init()
    
    var tableLimitsNode = FLTableLimitsNode.init()
    
    var firstTargetPointNode = FLTargetPointNode.init(zPosition: 1)
    var secondTargetPointNode = FLTargetPointNode.init(zPosition: 5)
    var thirdTargetPointNode = FLTargetPointNode.init(zPosition: -3)
    
    var redBallsBoxNode = FLBallsBoxNode.init(numberOfBalls: 5, ballsRadius: 0.5)
    lazy var blueBallsBoxNode: FLBallsBoxNode = {
        let blueBallsBoxNode = FLBallsBoxNode.init(numberOfBalls: 5, ballsRadius: 0.5)
        
        blueBallsBoxNode.position.x = -blueBallsBoxNode.position.x
        
        return blueBallsBoxNode
    }()
    
    lazy var firstShoeNode = FLHorsesShoeNode.init(zPosition: 0)
    lazy var secondShoeNode = FLHorsesShoeNode.init(zPosition: 5)
    lazy var thirdShoeNode = FLHorsesShoeNode.init(zPosition: -5)
    
    var ballNode: FLBallNode?
    
    override init() {
        super.init()
        
        rootNode.addChildNode(cameraNode)
        rootNode.addChildNode(lightNode)
        rootNode.addChildNode(tableNode)
        tableNode.addChildNode(firstTargetPointNode)
        tableNode.addChildNode(secondTargetPointNode)
        tableNode.addChildNode(thirdTargetPointNode)
//        tableNode.addChildNode(firstShoeNode)
//        tableNode.addChildNode(secondShoeNode)
//        tableNode.addChildNode(thirdShoeNode)
        rootNode.addChildNode(redBallsBoxNode)
        rootNode.addChildNode(blueBallsBoxNode)
        rootNode.addChildNode(tableLimitsNode)

        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = SCNVector3.init(0, -100, 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addNewBall() {
        
        var newBall: FLBallNode?
        var currentTeam: BallFlowTeam?
        
        switch state {
        case .redInitial, .blueInitial:
            break
        case .redPlaying:
            newBall = redBallsBoxNode.pull()
            currentTeam = .red
        case .bluePlaying:
            newBall = blueBallsBoxNode.pull()
            currentTeam = .blue
        }
        
        if let newBall = newBall {
            newBall.position = SCNVector3.zero
            newBall.position.y = 1
            newBall.position.x = -10
            newBall.position.z = -5
            
            rootNode.addChildNode(newBall)
            self.ballNode = newBall
        } else if let currentTeam = currentTeam {
            self.delegate?.finished(team: currentTeam)
        }
    }
    
    func initiateGame(forTeam team: BallFlowTeam) {
        
        switch team {
        case .red:
            self.state = .redPlaying
        case .blue:
            self.state = .bluePlaying
        }
        
        rotateTable {
            self.addNewBall()
        }
    }
    
    func rotateTable(completion: (() -> ())? = nil) {
        tableNode.runAction(SCNAction.sequence([
            SCNAction.rotateTo(x: 0.1, y: 0, z: 0, duration: 1),
            SCNAction.run({ (_) in
                DispatchQueue.main.async {
                    completion?()
                }
            })
        ]))
    }
    
    func moveBall(withForce force: SCNVector3) {
        ballNode?.physicsBody?.applyForce(force, asImpulse: true)
    }
}

extension BallFlowScene: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
     
        if contact.checkCollisionBetween(nodeTypeA: FLBallNode.self, nodeTypeB: FLTableLimitsNode.self) {
            self.ballNode?.removeFromParentNode()
            addNewBall()
        }
    }
}
