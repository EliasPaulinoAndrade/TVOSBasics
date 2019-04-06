//
//  GamesComunicator.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit

class GameController {
    
    var gameManager = GamesManager.init()
    weak var currentController: GameViewControllerProtocol?
    
    init(withGameViewControler gameViewController: GameViewControllerProtocol) {
        self.currentController = gameViewController
    }
}

extension GameController: GameViewControllerDelegate {
    func newPoints(points: Int) {
        guard let currentTeam = gameManager.currentRound?.currentTeam,
              let currentController = self.currentController,
              let currentTeamPoints = gameManager.currentRound?.addPoints(points) else {
            return
        }
        
        currentController.setViewForPointsChange(ofTeam: currentTeam, points: currentTeamPoints)
    }
    
    func teamHasFinished() {
        guard let currentTeam = gameManager.currentRound?.currentTeam,
              let currentController = self.currentController,
              let currentRound = gameManager.currentRound else {
                
            return
        }
        
        switch currentTeam {
        case .blue:
            if currentRound.changeTeamTo(.red) {
                currentController.setViewForChangeOf(team: .red)
            } else if gameManager.beginNextRound(byTeam: .red, andNumberOfTeams: 2) {
               currentController.setViewForChangeOfRound(toTeam: .red)
            } else {
                currentController.setViewForEndGame()
            }
        case .red:
            
            if currentRound.changeTeamTo(.blue) {
                currentController.setViewForChangeOf(team: .blue)
            } else if gameManager.beginNextRound(byTeam: .blue, andNumberOfTeams: 2) {
                currentController.setViewForChangeOfRound(toTeam: .blue)
            } else {
                currentController.setViewForEndGame()
            }
        }
    }
    
    func beginGame(withTeam team: Team) -> Bool {
        guard let currentController = self.currentController else {
            return false
        }
        
        gameManager.beginNextGame(
            ofGameType: currentController.gameType,
            numberOfRounds: currentController.numberOfRounds
        )
        
        return gameManager.beginNextRound(byTeam: team, andNumberOfTeams: 2)
    }
}
