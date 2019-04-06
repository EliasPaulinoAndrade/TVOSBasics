//
//  SCScene+loadSceneNode.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

extension SCNScene {
    
    /// Load a node from a scene. Normally used to get 3d objects from scenes where only they matters.
    ///
    /// - Parameters:
    ///   - sceneName: the scene file name
    ///   - nodeName: the node file name
    /// - Returns: the node, if it exists
    static func loadSceneNode(sceneName: String, nodeName: String) -> SCNNode? {
        if let node = SCNScene.init(named: sceneName)?.rootNode.childNode(withName: nodeName, recursively: false) {
            return node
        }
        return nil
    }
}
