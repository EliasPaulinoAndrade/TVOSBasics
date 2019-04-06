//
//  CollisionCenter.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

/// a class responsible by giving CategoryIds for nodes and making them collision and contact masks
class CollisionCenter {
    
    static var standard = CollisionCenter.init()
    
    var collisorNodes: [String: Int] = [:]
    
    var usedMasks = 0
    
    @discardableResult
    func registerCategoryMaskTo<NodeType: SCNNode>(nodeType: NodeType.Type) -> Int {
        if let registeredMask = registeredMaskTo(nodeType: nodeType) {
            return registeredMask
        }
        
        let nodeTypeName = String.init(describing: nodeType)
        
        usedMasks += 1
        
        let nextMask = NSDecimalNumber.init(decimal: pow(2, usedMasks)).intValue
        collisorNodes[nodeTypeName] = nextMask
        
        return nextMask
    }
    
    func registeredMaskTo<NodeType: SCNNode>(nodeType: NodeType.Type) -> Int? {
        
        let nodeTypeName = String.init(describing: nodeType)
        
        return collisorNodes[nodeTypeName]
    }
    
    func registeredMasksTo<NodeType: SCNNode>(nodeTypes: [NodeType.Type]) -> [Int] {
        
        var categoryMasks: [Int] = []
        
        for nodeType in nodeTypes {
            if let nodeTypeMask = registeredMaskTo(nodeType: nodeType) {
                categoryMasks.append(nodeTypeMask)
            }
        }
        
        return categoryMasks
    }
    
    func resultMask<NodeType: SCNNode>(nodeTypes: [NodeType.Type]) -> Int {
        
        var collisionMask = 0
        
        for nodeType in nodeTypes {
            if let nodeTypeMask = registeredMaskTo(nodeType: nodeType) {
                collisionMask = collisionMask | nodeTypeMask
            } else {
                let nodeTypeMask = registerCategoryMaskTo(nodeType: nodeType)
                collisionMask = collisionMask | nodeTypeMask
            }
        }
        
        return collisionMask
    }
}
