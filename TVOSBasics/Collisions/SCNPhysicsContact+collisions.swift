//
//  SCNPhysicsContact+collisions.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

extension SCNPhysicsContact {
    
    var firstNode: SCNNode? {
        guard let nodeACategory = nodeA.physicsBody?.categoryBitMask,
              let nodeBCategory = nodeB.physicsBody?.categoryBitMask else {
            return nil
        }
        
        if nodeACategory < nodeBCategory {
            return nodeA
        } else {
            return nodeB
        }
    }
    
    var secondNode: SCNNode? {
        guard let nodeACategory = nodeA.physicsBody?.categoryBitMask,
            let nodeBCategory = nodeB.physicsBody?.categoryBitMask else {
                return nil
        }
        
        if nodeACategory < nodeBCategory {
            return nodeB
        } else {
            return nodeA
        }
    }
    
    func checkCollisionBetween<NodeTypeA: SCNNode, NodeTypeB: SCNNode>(nodeTypeA: NodeTypeA.Type, nodeTypeB: NodeTypeB.Type) -> Bool {
        
        if (nodeA is NodeTypeA && nodeB is NodeTypeB) || (nodeA is NodeTypeB && nodeB is NodeTypeA) {
            return true
        }
        return false
    }
    
    func checkCollisionBetween<NodeTypeA: SCNNode, NodeTypeB: SCNNode>(nodeTypeA: NodeTypeA.Type, nodeTypeB: NodeTypeB.Type) -> (nodeOfTypeA: NodeTypeA, nodeOfTypeB: NodeTypeB)? {
        
        if let nodeA = nodeA as? NodeTypeA, let nodeB = nodeB as? NodeTypeB {
            return (nodeOfTypeA: nodeA, nodeOfTypeB: nodeB)
        }
        
        if let nodeA = nodeA as? NodeTypeB, let nodeB = nodeB as? NodeTypeA {
            return (nodeOfTypeA: nodeB, nodeOfTypeB: nodeA)
        }
        return nil
    }
}
