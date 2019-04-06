//
//  RoundManager.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class GamesManager {
    
    var wonRounds: [Team: Int] = [:]
    var currentRound: Round?
    var currentGame: Game?
    var oldRounds: [Round] = []
    var oldGames: [Game] = []
    
    private func addWonRound(toTeam team: Team) {
        if let wonRoundsForTeam = wonRounds[team] {
            wonRounds[team] = wonRoundsForTeam + 1
        } else {
            wonRounds[team] = 1
        }
    }
    
    func teamWithMoreRounds() -> (team: Team, rounds: Int)? {
        
        var maxRoundsTeam: (team: Team, rounds: Int)?
        
        for (team, rounds) in wonRounds {
            if let safeMaxRoundsTeam = maxRoundsTeam, safeMaxRoundsTeam.rounds < rounds {
                maxRoundsTeam = (team, rounds)
            } else {
                maxRoundsTeam = (team, rounds)
            }
        }
        
        return maxRoundsTeam
    }
    
    func beginNextGame(ofGameType gameType: GameType, numberOfRounds: Int) {
        if let currentGame = self.currentGame {
            oldGames.append(currentGame)
        }
        
        currentGame = Game.init(gameType, withNumberOfRounds: numberOfRounds)
    }
    
    func beginNextRound() -> Bool {
        guard let currentGame = self.currentGame, currentGame.hasMoreRounds() else {
            return false
        }
        
        if let currentRound = self.currentRound {
            oldRounds.append(currentRound)
            if let teamWithMorePoints = self.currentRound?.teamWithMorePoints() {
                addWonRound(toTeam: teamWithMorePoints.team)
            }
        }
        
        currentRound = Round.init(withGameType: currentGame.gameType)
        
        return true
    }

    func newPoints(_ points: Int, toTeam team: Team) -> Int? {
        return currentRound?.addPoints(points, toTeam: team)
    }
}
