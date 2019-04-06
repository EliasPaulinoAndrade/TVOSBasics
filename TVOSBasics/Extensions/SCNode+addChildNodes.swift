//
//  SCNode+addChildNodes.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import SceneKit

extension SCNNode {
    func addChildNodes(_ nodes: [SCNNode]) {
        for node in nodes {
            addChildNode(node)
        }
    }
}
