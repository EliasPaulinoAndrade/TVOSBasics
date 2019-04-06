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
        lightNode.light?.intensity = 1500
        lightNode.position = SCNVector3(x: 0, y: 20, z: 0)
        
        return lightNode
    }()
    
    var tableNode = FLTableNode.init()
    
    var tableLimitsNode = FLTableLimitsNode.init()

    var firstWinPointNode = FLWinPointNode.init(zPosition: -3.5, withColor: UIColor.flPink)
    var secondWinPointNode = FLWinPointNode.init(zPosition: 1, withColor: UIColor.flBlue)
    var thirdWinPointNode = FLWinPointNode.init(zPosition: 5, withColor: UIColor.flGreen)
    var initialWinPointNode: FLWinPointNode = {
        let initialWinPointNode = FLWinPointNode.init(zPosition: 5, includeTargetPoint: false)
        
        initialWinPointNode.position.x = -initialWinPointNode.position.x
        
        return initialWinPointNode
    }()
    
    var redBallsBoxNode = FLBallsBoxNode.init(numberOfBalls: 5, ballsRadius: 0.5)
    lazy var blueBallsBoxNode: FLBallsBoxNode = {
        let blueBallsBoxNode = FLBallsBoxNode.init(numberOfBalls: 5, ballsRadius: 0.5)
        
        blueBallsBoxNode.position.x = -blueBallsBoxNode.position.x
        
        return blueBallsBoxNode
    }()
    
    var testObstacle = FLObstacleNode.init()
    
    var ballNode: FLBallNode?
    
    override init() {
        super.init()
        
        rootNode.addChildNode(cameraNode)
        rootNode.addChildNode(lightNode)
        rootNode.addChildNode(tableNode)
        tableNode.addChildNode(initialWinPointNode)
        tableNode.addChildNode(firstWinPointNode)
        tableNode.addChildNode(secondWinPointNode)
        tableNode.addChildNode(thirdWinPointNode)
        tableNode.addChildNode(testObstacle)
        rootNode.addChildNode(redBallsBoxNode)
        rootNode.addChildNode(blueBallsBoxNode)
        rootNode.addChildNode(tableLimitsNode)

        
        self.physicsWorld.contactDelegate = self
//        self.physicsWorld.gravity = SCNVector3.init(0, -100, 0)
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
            newBall.position.x = -10.5
            newBall.position.z = -5
            
            rootNode.addChildNode(newBall)
            self.ballNode = newBall
        } else if let currentTeam = currentTeam {
            self.delegate?.finished(team: currentTeam)
        }
    }
    
    func removeCurrentBall() {
        rootNode.runAction(SCNAction.sequence([
            SCNAction.wait(duration: 0.5),
            SCNAction.run({ (_) in
                self.ballNode?.removeFromParentNode()
                self.ballNode = nil
                
                self.addNewBall()
            })
        ]))
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
        } else if let (ballNode, targetPointNode) = contact.checkCollisionBetween(
            nodeTypeA: FLBallNode.self,
            nodeTypeB: FLTargetPointNode.self), !ballNode.wasUsed {
            
            ballNode.wasUsed = true
            
            removeCurrentBall()
            
            switch targetPointNode.parent {
                
            case firstWinPointNode:
                print("150 pontos")
            case secondWinPointNode:
                print("100 pontos")
            case thirdWinPointNode:
                print("50 pontos")
            default:
                break
            }
        }
    }
}
