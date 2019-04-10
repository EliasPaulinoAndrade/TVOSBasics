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
    
    var state = PaperPlateGameState.redPlaying
    var currentBall: BallNode?
    let nPlates = 10
    let possiblePoints = [100, 50, 20, 10, 5]
    let totalPoints = 1000
        
    lazy var cameraNode: SCNNode = {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 10, z: 17)
        cameraNode.camera?.fieldOfView = 90
        let rad = -20 * Float.pi / 180
        cameraNode.eulerAngles = SCNVector3Make(rad, 0, 0)
        
        return cameraNode
    }()
    
    lazy var lightNode: SCNNode = {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.light?.intensity = 1500
        let rad = -20 * Float.pi / 180
        lightNode.eulerAngles = SCNVector3Make(rad, 0, 0)
        lightNode.position = SCNVector3(x: 0, y: 20, z: 12)
        
        return lightNode
    }()
    
    lazy var straw: PPStrawNode = {
        let strawNode = PPStrawNode()
        
        return strawNode
    }()
    
    lazy var boxBollsTeam1: BallsBoxNode = {
        let balls = BallsBoxNode(numberOfBalls: 5, ballsRadius: 0.25)
        balls.position = SCNVector3(x: 15.0, y: 5.0, z: 8.0)
    
        return balls
    }()
    
    lazy var boxBollsTeam2: BallsBoxNode = {
        let balls = BallsBoxNode(numberOfBalls: 5, ballsRadius: 0.25)
        balls.position = SCNVector3(x: -15.0, y: 5.0, z: 8.0)
        
        return balls
    }()
    
    lazy var tableNode: TableNode = {
        let table = TableNode()
        let xScale = table.scale.x
        let yScale = table.scale.y
        let zScale = table.scale.z
        table.scale = SCNVector3(x: xScale, y: yScale, z: zScale * 1.5 )
        //table.position.y -= 10
        return table
    }()
    
    lazy var plates: [PPPlateNode] = {
        var plates: [PPPlateNode] = []
        var points = 0
        var randonPoint = 0
        for i in 0...nPlates {
            let plate = PPPlateNode()
            repeat {
                randonPoint = possiblePoints.randomElement() ?? 5
            }while (randonPoint + points > totalPoints)
            plate.points = randonPoint
            points += randonPoint
            plates.append(plate)
        }
        return plates
    }()
    
    lazy var tableLimitsNode: TableLimitsNode = {
        let limits = TableLimitsNode()
        limits.position.z = 5
  
        return limits
    }()
    
    var walls = WallsBoxNode()
    
    
    override init() {
        super.init()
//        self.physicsWorld.gravity = SCNVector3Make(0, -9.8, 0);
        rootNode.addChildNode(cameraNode)
        rootNode.addChildNode(straw)
        rootNode.addChildNode(lightNode)
        rootNode.addChildNode(tableNode)
        rootNode.addChildNode(boxBollsTeam1)
        rootNode.addChildNode(boxBollsTeam2)
        rootNode.addChildNode(walls)
        rootNode.addChildNode(tableLimitsNode)
        rootNode.addChildNodes(plates)
        self.physicsWorld.contactDelegate = self
        currentBall?.physicsBody?.isAffectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initiateRound(forTeam team: Team) {
        switch team {
        case .red:
            self.state = .redPlaying
            self.boxBollsTeam1.fill()
            self.boxBollsTeam2.fill()
        case .blue:
            self.state = .bluePlaying
            self.boxBollsTeam1.fill()
            self.boxBollsTeam2.fill()
        }
        
        self.addNewBall()
    }
    
    func addNewBall() {
        
        var newBall: BallNode?
        var currentTeam: Team?
        
        switch state {
        case .redPlaying:
            newBall = boxBollsTeam1.pull()
            currentTeam = .red
        case .bluePlaying:
            newBall = boxBollsTeam2.pull()
            currentTeam = .blue
        }
        
        if let newBall = newBall {
            newBall.position = SCNVector3.zero
            newBall.position.y = straw.position.y
            newBall.position.x = straw.position.x
            newBall.position.z = straw.position.z
            
            rootNode.addChildNode(newBall)
            self.currentBall = newBall
            self.currentBall?.physicsBody?.isAffectedByGravity = false
        }
    }
    
    func throwBall(withForce force: SCNVector3) {
        currentBall?.physicsBody?.isAffectedByGravity = true
        self.currentBall?.physicsBody?.applyForce(force, asImpulse: true)
    }
    
    func moveStraw(to distance: CGPoint) {
        var moveX = Float(distance.x / 10)
        if distance.x >= 110 {
            moveX = 11
        } else if distance.x <= -110{
            moveX = -11
        }
        let finalPositionX = SCNVector3(moveX, straw.position.y, straw.position.z)
        let actionx = SCNAction.move(to: finalPositionX, duration: 0.01)
        var rotate = Float(distance.y / 10)
        if distance.y >= -8.5 {
            rotate = -0.85
        } else if distance.y <= -17.50 {
            rotate = -1.750
        }
        let actionz = SCNAction.rotateTo(x: CGFloat(rotate) , y: 0, z: 0, duration: 0.01)
        if let ball = currentBall {
            straw.runAction(SCNAction.group([actionx, actionz])) {
                self.straw.position.x = moveX
                self.straw.rotation.x = rotate
            }
            
            ball.runAction(SCNAction.group([actionx, actionz])) {
                ball.position.x = moveX
                ball.rotation.x = rotate
            }
        }
    }
    
    func initiateGame(forTeam team: Team) {
        
        switch team {
        case .red:
            self.state = .redPlaying
        case .blue:
            self.state = .bluePlaying
        }
    }
    
    func newPlates() {
        plates.sort { (plate1, plate2) -> Bool in
            guard let points1 = plate1.points, let points2 = plate2.points else { return false}
            return points1 >= points2
        }
        var auxZ: Float = -6.0
        var auxX: Float = -10.0
        let limitRandon: Float = 4
        var incremend: Float = 0.1
        for (index, plate) in plates.enumerated() {
            guard let platePoints = plate.points else { return }
            let pointsNode = PPPoints(withText: String(platePoints))
            if index < 4 {
                plate.position.x = auxX
                plate.position.z = auxZ + Float.random(in: 1...limitRandon)
                auxX += Float.random(in: 5...7)
                incremend += 0.5
            } else if index > 4, index < 8 {
                plate.position.x = auxX
                plate.position.z = auxZ + Float.random(in: 1...limitRandon)
                auxX += Float.random(in: 7...9)
                incremend += 1.0
            } else if index >= 9 {
                plate.position.x = auxX
                plate.position.z = auxZ + Float.random(in: 1...limitRandon)
                auxX += Float.random(in: 6...7)
                incremend += 1.0
            } else {
                auxX = -12 + incremend
                auxZ += 6
            }
            let (min, max) = plate.boundingBox
            pointsNode.position = SCNVector3(x: (max.x - min.x) / 2 + min.x, y: plate.position.y, z: plate.position.z)
            plate.addChildNode(pointsNode)
        }
    }
}

extension PaperPlateScene: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.checkCollisionBetween(nodeTypeA: BallNode.self, nodeTypeB: TableLimitsNode.self) {
            self.currentBall?.removeFromParentNode()
            addNewBall()
        } else if let (ballNode, targetPlate) = contact.checkCollisionBetween1(nodeTypeA: BallNode.self, nodeTypeB: PPPlateNode.self), !ballNode.wasUsed {
            targetPlate.physicsBody?.isAffectedByGravity = true
            ballNode.wasUsed = true
//            ballNode.runAction(SCNAction.wait(duration: 1)) {
//                ballNode.removeFromParentNode()
//            }
            
        } else if let (plate1, plate2) = contact.checkCollisionBetween1(nodeTypeA: PPPlateNode.self, nodeTypeB: PPPlateNode.self) {
            plate1.physicsBody?.isAffectedByGravity = true
            plate2.physicsBody?.isAffectedByGravity = true
        }
    }
}
