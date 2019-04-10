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
    
    var tableNode = TableNode.init()
    
    var tableLimitsNode = TableLimitsNode.init()

    var firstWinPointNode = FLWinPointNode.init(zPosition: -3.5, withColor: UIColor.flPink, withText: "150")
    var secondWinPointNode = FLWinPointNode.init(zPosition: 1, withColor: UIColor.flBlue, withText: "100")
    var thirdWinPointNode = FLWinPointNode.init(zPosition: 5, withColor: UIColor.flGreen, withText: "50")
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
    
    lazy var obstacles: [FLObstacleNode] = {
        let obstaclePositions: [(x: Float, z: Float, rotation: Float)] = [
            (x: 0.0, z: 5.0, rotation: 0.0),
            (x: 5.0, z: 6.0, rotation: 0.7),
            (x: 5.0, z: -1.0, rotation: -0.7),
            (x: -7.0, z: -1.0, rotation: 0.7)
        ]
        var obstacles: [FLObstacleNode] = []
        
        for obstaclePosition in obstaclePositions {
            let obstacle = FLObstacleNode.init()
            
            obstacle.position = SCNVector3.init(obstaclePosition.x, 0.676, obstaclePosition.z)
            obstacle.eulerAngles.y += obstaclePosition.rotation
            
            obstacles.append(obstacle)
        }
        
        return obstacles
    }()
    
    var testWalls = WallsBoxNode.init()
    
    var ballNode: BallNode?
    
    override init() {
        super.init()
        
        rootNode.addChildNode(cameraNode)
        rootNode.addChildNode(lightNode)
        rootNode.addChildNode(tableNode)
        tableNode.addChildNode(initialWinPointNode)
        tableNode.addChildNode(firstWinPointNode)
        tableNode.addChildNode(secondWinPointNode)
        tableNode.addChildNode(thirdWinPointNode)
        tableNode.addChildNodes(obstacles)
        rootNode.addChildNode(redBallsBoxNode)
        rootNode.addChildNode(blueBallsBoxNode)
        rootNode.addChildNode(tableLimitsNode)
        rootNode.addChildNode(testWalls)

        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = SCNVector3.init(0, -100, 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addNewBall() {
        
        var newBall: BallNode?
        var currentTeam: Team?
        
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
        } else if let _ = currentTeam {
            self.delegate?.finished()
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
    
    func initiateGame(forTeam team: Team) {
        
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
    
    func initiateRound(forTeam team: Team) {
        switch team {
        case .red:
            self.state = .redPlaying
            self.redBallsBoxNode.fill()
            self.blueBallsBoxNode.fill()
        case .blue:
            self.state = .bluePlaying
            self.redBallsBoxNode.fill()
            self.blueBallsBoxNode.fill()
        }
        
        self.addNewBall()
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
     
        if contact.checkCollisionBetween(nodeTypeA: BallNode.self, nodeTypeB: TableLimitsNode.self) {
            self.ballNode?.removeFromParentNode()
            addNewBall()
        } else if let (ballNode, targetPointNode) = contact.checkCollisionBetween(
            nodeTypeA: BallNode.self,
            nodeTypeB: FLTargetPointNode.self), !ballNode.wasUsed {
            
            ballNode.wasUsed = true
            
            removeCurrentBall()
            
            switch targetPointNode.parent {
                
            case firstWinPointNode:
                delegate?.newPoints(points: 150)
            case secondWinPointNode:
                delegate?.newPoints(points: 100)
            case thirdWinPointNode:
                delegate?.newPoints(points: 50)
            default:
                break
            }
        }
    }
}
