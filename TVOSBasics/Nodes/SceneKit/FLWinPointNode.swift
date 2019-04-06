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
    
    lazy var horsesShoeNode = FLHorsesShoeNode.init(withColor: self.color)
    let targetPointNode = FLTargetPointNode.init()
    
    let color: UIColor?
    
    init(zPosition: Float, includeTargetPoint: Bool = true, withColor color: UIColor? = nil) {
        
        self.color = color
        
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
