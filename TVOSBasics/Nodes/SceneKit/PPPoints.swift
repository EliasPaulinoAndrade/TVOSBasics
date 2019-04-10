//
//  PPPoints.swift
//  TVOSBasics
//
//  Created by Paloma Bispo on 10/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//
import Foundation
import SceneKit

class PPPoints: SCNNode {
    
    var pointsText = SCNText.init(string: "150", extrusionDepth: 0.1)
    
    lazy var pointsTextNode: SCNNode = {
        pointsText.font = UIFont.boldSystemFont(ofSize: 1)
        pointsText.materials.first?.diffuse.contents = UIImage.init(named: "fontTexture")
        
        let pointsTextNode = SCNNode.init(geometry: pointsText)
        pointsTextNode.eulerAngles.x = -Float.pi/2
        return pointsTextNode
    }()
    
    init(withText text: String) {
        pointsText.string = text
        
        super.init()
        
        let targetPointGeometry = SCNCylinder.init(radius: 1, height: 0.05)
        targetPointGeometry.materials.first?.diffuse.contents = UIColor.clear
        geometry = targetPointGeometry
        
        physicsBody = SCNPhysicsBody.init(type: .kinematic, shape: nil)
        
        willContactWith(nodeTypes: [BallNode.self])
        
        addChildNode(pointsTextNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

