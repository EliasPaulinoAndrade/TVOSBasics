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
    
    
    /// register to the node a category
    ///
    /// - Parameter collisionCenter: the collision center
    /// - Returns: the category id generated
    @discardableResult
    func registerCategoryMask(inCollisionCenter collisionCenter: CollisionCenter = CollisionCenter.standard) -> Int {
        let selfCategoryMask = collisionCenter.registerCategoryMaskTo(nodeType: type(of: self))
        
        self.physicsBody?.categoryBitMask = selfCategoryMask
        
        return selfCategoryMask
    }

    /// Set the collision mask to the node. If the node dont have categoryId, it is created.
    ///
    /// - Parameters:
    ///   - nodeTypes: the nodes types that can collide with this node
    ///   - collisionCenter: the collision center
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
    
    /// Set the contact mask to the node. If the node dont have categoryId, it is created.
    ///
    /// - Parameters:
    ///   - nodeTypes: the nodes types that can contact with this node
    ///   - collisionCenter: the collision center
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
