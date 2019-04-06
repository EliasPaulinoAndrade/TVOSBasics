//
//  BallFlowSceneDelegate.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol BallFlowSceneDelegate: AnyObject {
    func finished()
    func newPoints(points: Int)
}
