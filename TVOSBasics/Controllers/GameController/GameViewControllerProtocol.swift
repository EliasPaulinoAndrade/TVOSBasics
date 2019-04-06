//
//  GameControllerProtocol.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

protocol GameViewControllerProtocol: UIViewController {
    
    var gameType: GameType { get }
    var numberOfRounds: Int { get }
    var gameDelegate: GameViewControllerDelegate? { get set }
    
    func setViewForChangeOf(team: Team)
    func setViewForChangeOfRound(toTeam team: Team)
    func setViewForEndGame()
    func setViewForPointsChange(ofTeam team: Team, points: Int)
}
