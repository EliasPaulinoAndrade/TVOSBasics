//
//  GameControllerDelegate.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol GameControllerDelegate: AnyObject {
    
    @discardableResult
    func beginGame(withTeam: Team) -> Bool
    func teamHasFinished()
    func newPoints(points: Int)
}

protocol GameControllerDataSource: AnyObject {
    
}
