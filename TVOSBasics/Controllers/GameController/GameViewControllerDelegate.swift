//
//  GameControllerDelegate.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol GameViewControllerDelegate: AnyObject {
    
    @discardableResult
    func beginGame(withTeam: Team) -> Bool
    func teamHasFinished()
    func newPoints(points: Int)
    func currentInfo()->(redRounds: Int?, blueRounds: Int?, currentRound: Int?)
}
