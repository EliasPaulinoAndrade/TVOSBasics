//
//  FLWinPointNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

class FLWinPointNode: SCNNode {
    
    let horsesShoeNode = FLHorsesShoeNode.init()
    let targetPointNode = FLTargetPointNode.init()
    
    
    init(zPosition: Float, includeTargetPoint: Bool = true) {
        super.init()
        
        position.x = 11
        position.y += 0.5
        position.z = zPosition
        
        
        if includeTargetPoint {
            addChildNode(targetPointNode)
        }
        addChildNode(horsesShoeNode)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
