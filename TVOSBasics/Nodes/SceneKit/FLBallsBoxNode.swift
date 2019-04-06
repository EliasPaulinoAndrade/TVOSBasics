//
//  FLBallsBoxNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

class FLBallsBoxNode: SCNNode {
    
    let numberOfBalls: Int
    let ballsRadius: CGFloat
    
    var ballsQueue = Queue<FLBallNode>()
    
    lazy var height: CGFloat = {
        return 2.1 * CGFloat(numberOfBalls) * ballsRadius
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
        shoeNode.position.y = Float(-self.height/2 - 10)
        
        return shoeNode
    }()
    
    init(numberOfBalls: Int, ballsRadius: CGFloat) {
        self.numberOfBalls = numberOfBalls
        self.ballsRadius = ballsRadius
        
        super.init()
        
        let boxGeometry = SCNBox.init(
            width: width,
            height: height,
            length: length,
            chamferRadius: 0
        )
        geometry = boxGeometry
        geometry?.materials.first?.diffuse.contents = UIImage.init(named: "ballsBoxTexture")
        geometry?.materials.first?.isDoubleSided = true
    
        position.x = -15.5 - Float(width/2)
        position.z = 0
        position.y = Float(height/2)
        
        let shape = SCNPhysicsShape.init(
            geometry: boxGeometry,
            options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.concavePolyhedron]
        )
        
        physicsBody = SCNPhysicsBody.init(type: .static, shape: shape)
        
        willCollideWith(nodeTypes: [FLBallNode.self])
        
        add(balls: ballNodes(numberOfBalls: numberOfBalls, ballRadius: ballsRadius))
        
        addChildNode(shoeNode)
    }
    
    func ballNodes(numberOfBalls: Int, ballRadius: CGFloat) -> [FLBallNode] {
        
        var ballNodes: [FLBallNode] = []
        
        for ballIndex in 0..<numberOfBalls {
            let ballNode = FLBallNode.init(withRadius: ballRadius)
            
            ballNode.position = SCNVector3.zero
            ballNode.position.y += Float(ballIndex) * Float(ballRadius * 2.1)
            ballNode.position.y += -Float(height/2) + Float(ballRadius/2)
            
            ballNodes.append(ballNode)
        }
        
        return ballNodes
    }
    
    func add(balls: [FLBallNode]) {
        for ball in balls {
            addChildNode(ball)
            ballsQueue.push(item: ball)
        }
    }
    
    func pull() -> FLBallNode? {
        let firstBall = ballsQueue.pull()
        
        firstBall?.removeFromParentNode()
        
        return firstBall
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
