//
//  SCNode+collisions.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

extension SCNNode {
    
    @discardableResult
    func registerCategoryMask(inCollisionCenter collisionCenter: CollisionCenter = CollisionCenter.standard) -> Int {
        let selfCategoryMask = collisionCenter.registerCategoryMaskTo(nodeType: type(of: self))
        
        self.physicsBody?.categoryBitMask = selfCategoryMask
        
        return selfCategoryMask
    }

    func willCollideWith<NodeType: SCNNode>(nodeTypes: [NodeType.Type], collisionCenter: CollisionCenter = CollisionCenter.standard) {
        if let _ = collisionCenter.registeredMaskTo(nodeType: type(of: self)), categoryBitMask != 1 {
            let collisionMask = collisionCenter.resultMask(nodeTypes: nodeTypes)
            
            self.physicsBody?.collisionBitMask = collisionMask
        } else {
            registerCategoryMask(inCollisionCenter: collisionCenter)
            let collisionMask = collisionCenter.resultMask(nodeTypes: nodeTypes)
            
            self.physicsBody?.collisionBitMask = collisionMask
        }
    }
    
    func willContactWith<NodeType: SCNNode>(nodeTypes: [NodeType.Type], collisionCenter: CollisionCenter = CollisionCenter.standard) {
        if let _ = collisionCenter.registeredMaskTo(nodeType: type(of: self)), categoryBitMask != 1 {
            let contactMask = collisionCenter.resultMask(nodeTypes: nodeTypes)
            
            self.physicsBody?.contactTestBitMask = contactMask
        } else {
            registerCategoryMask(inCollisionCenter: collisionCenter)
            let contactMask = collisionCenter.resultMask(nodeTypes: nodeTypes)
            
            self.physicsBody?.contactTestBitMask = contactMask
        }
    }
}
