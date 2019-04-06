//
//  FLWallsBoxNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

class FLWallsBoxNode: SCNNode {
    override init() {
        super.init()
        
        let boxGeomtry = SCNBox.init(width: 90, height: 50, length: 50, chamferRadius: 0)
        
        let boxWallMaterial = SCNMaterial.init()
        boxWallMaterial.diffuse.contents = UIImage.init(named: "wallsTexture")
        boxWallMaterial.isDoubleSided = true
        
        let boxFloorMaterial = SCNMaterial.init()
        boxFloorMaterial.diffuse.contents = UIColor.flGrayBlue
        boxFloorMaterial.isDoubleSided = true
        
        boxGeomtry.materials = [boxWallMaterial, boxWallMaterial, boxWallMaterial,
                                boxWallMaterial, boxWallMaterial, boxFloorMaterial]
        
        geometry = boxGeomtry
        position.y = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
