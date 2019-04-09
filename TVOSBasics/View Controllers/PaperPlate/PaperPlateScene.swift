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
    
    weak var delegate: BallFlowSceneDelegate?
    
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
        lightNode.position = SCNVector3(x: 0, y: 20, z: 0)
        
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
            plate.points = points
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
            newBall.position.y = 2.0
            newBall.position.x = 0.0
            newBall.position.z = 13
            
            rootNode.addChildNode(newBall)
            self.currentBall = newBall
        } else if let _ = currentTeam {
            self.delegate?.finished()
        }
    }
    
    func throwBall(withForce force: SCNVector3) {
        self.currentBall?.physicsBody?.applyForce(force, asImpulse: true)
    }
    
    func moveStraw(to distance: CGPoint) {
        let finalPosition = SCNVector3(Float(distance.x / 100), straw.position.y, straw.position.z)
        let action = SCNAction.move(to: finalPosition, duration: 0.001)
        straw.runAction(action)
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
                auxX += Float.random(in: 7...9)
                incremend += 1.5
            } else {
                auxX = -12 + incremend
                auxZ += 6
            }
        }
    }
}

extension PaperPlateScene: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        if contact.checkCollisionBetween(nodeTypeA: BallNode.self, nodeTypeB: TableLimitsNode.self) {
            self.currentBall?.removeFromParentNode()
            addNewBall()
        }
    }
}
