//
//  FLBallsBoxNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

/// the box where the balls stay before to be used
class BallsBoxNode: SCNNode {
    
    let numberOfBalls: Int
    let ballsRadius: CGFloat
    
    var ballsQueue = Queue<BallNode>()
    
    lazy var height: CGFloat = {
        return max(2.1 * CGFloat(numberOfBalls) * ballsRadius, 4)
    }()
    
    lazy var width: CGFloat = {
        return 2.1 * ballsRadius
    }()
    
    lazy var length: CGFloat = {
        return 2.1 * ballsRadius
    }()
    
    lazy var shoeNode: SCNNode = {
        let shoeGeometry = SCNCylinder.init(radius: 0.1, height: 20)
        
        let shoeNode = SCNNode.init(geometry: shoeGeometry)
        shoeNode.position.y = Float(-self.height/2 - 10.05)
        
        return shoeNode
    }()
    
    init(numberOfBalls: Int, ballsRadius: CGFloat) {
        self.numberOfBalls = numberOfBalls
        self.ballsRadius = ballsRadius
        
        super.init()
        
        let boxWallTexture = SCNMaterial.init()
        boxWallTexture.diffuse.contents = UIImage.init(named: "ballsBoxTexture")
        boxWallTexture.isDoubleSided = true
        
        let boxFloorTexture = SCNMaterial.init()
        boxFloorTexture.diffuse.contents = UIColor.flBlue
        boxFloorTexture.isDoubleSided = true
        
        let boxGeometry = SCNBox.init(
            width: width,
            height: height,
            length: length,
            chamferRadius: 0
        )
        
        geometry = boxGeometry
        geometry?.materials = [boxWallTexture, boxWallTexture, boxWallTexture,
                               boxWallTexture, boxWallTexture, boxFloorTexture]
    
        position.x = -15.5 - Float(width/2)
        position.z = 0
        position.y = Float(height/2)
        
        let shape = SCNPhysicsShape.init(
            geometry: boxGeometry,
            options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.concavePolyhedron]
        )
        
        physicsBody = SCNPhysicsBody.init(type: .static, shape: shape)
        
        willCollideWith(nodeTypes: [BallNode.self])
        
        fill()
        
        addChildNode(shoeNode)
    }
    
    func ballNodes(numberOfBalls: Int, ballRadius: CGFloat) -> [BallNode] {
        
        var ballNodes: [BallNode] = []
        
        for ballIndex in 0..<numberOfBalls {
            let ballNode = BallNode.init(withRadius: ballRadius)
            
            ballNode.position = SCNVector3.zero
            ballNode.position.y += Float(ballIndex) * Float(ballRadius * 2.1)
            ballNode.position.y += -Float(height/2) + Float(ballRadius/2)
            
            ballNodes.append(ballNode)
        }
        
        return ballNodes
    }
    
    func fill() {
        add(balls: ballNodes(numberOfBalls: numberOfBalls, ballRadius: ballsRadius))
    }
    
    func add(balls: [BallNode]) {
        for ball in balls {
            addChildNode(ball)
            ballsQueue.push(item: ball)
        }
    }
    
    func pull() -> BallNode? {
        let firstBall = ballsQueue.pull()
        
        firstBall?.removeFromParentNode()
        
        return firstBall
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
