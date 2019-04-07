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
    
    var winnerInfo: (teamWithMoreRounds: Team, teamWithMoreRoundsPoints: Int)?
    
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
        guard let currentTeam = gameManager.currentRound?.currentTeam else {
                
            return
        }
        
        switch currentTeam {
        case .blue:
            beginNewTeam(team: .red)
        case .red:
            beginNewTeam(team: .blue)
        }
    }
    
    private func beginNewTeam(team: Team) {
        guard let currentController = self.currentController,
              let currentRound = gameManager.currentRound else {
                
            return
        }
        
        if currentRound.changeTeamTo(team) {
            currentController.setViewForChangeOf(team: team)
        } else if gameManager.beginNextRound(byTeam: team, andNumberOfTeams: 2) {
            
            let redRounds = gameManager.wonRounds[.red] ?? 0
            let blueRounds = gameManager.wonRounds[.blue] ?? 0
            
            currentController.setViewForChangeOfRound(toTeam: team, withRedRounds: redRounds, andBlueRounds: blueRounds)
            
            currentController.setViewForPointsChange(ofTeam: .red, points: 0)
            currentController.setViewForPointsChange(ofTeam: .blue, points: 0)
            
            checkForWinnerChange(redRounds: redRounds, blueRounds: blueRounds)
        } else {
            currentController.setViewForEndGame()
        }
    }
    
    private func checkForWinnerChange(redRounds: Int, blueRounds: Int) {
        
        var realWinnerTeam: Team
        var realWinnerRounds: Int
        
        var redWinner: Bool
        var blueWinner: Bool
        
        if redRounds > blueRounds {
            realWinnerTeam = .red
            realWinnerRounds = redRounds
            redWinner = true
            blueWinner = false
        } else if blueRounds > redRounds {
            realWinnerTeam = .blue
            realWinnerRounds = blueRounds
            redWinner = false
            blueWinner = true
        } else {
            currentController?.setViewForPositionChange(redWinner: false, blueWinner: false)
            return
        }
        
        if let (currentWinnerTeam, _) = self.winnerInfo {
            if currentWinnerTeam != realWinnerTeam {
                self.winnerInfo = (realWinnerTeam, realWinnerRounds)
                currentController?.setViewForPositionChange(redWinner: redWinner, blueWinner: blueWinner)
            }
        } else {
            self.winnerInfo = (realWinnerTeam, realWinnerRounds)
            currentController?.setViewForPositionChange(redWinner: redWinner, blueWinner: blueWinner)
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
