//
//  RoundManager.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class RoundManager {
    
    var numberOfRounds: Int
    var wonRounds: [BallFlowTeam: Int] = [:]
    var currentRound: Round?
    var oldRounds: [Round] = []
    
    init(withNumberOfRounds numberOfRounds: Int) {
        self.numberOfRounds = numberOfRounds
    }
    
    private func addWonRound(toTeam team: BallFlowTeam) {
        if let wonRoundsForTeam = wonRounds[team] {
            wonRounds[team] = wonRoundsForTeam + 1
        } else {
            wonRounds[team] = 1
        }
    }
    
    func teamWithMoreRounds() -> (team: BallFlowTeam, rounds: Int)? {
        
        var maxRoundsTeam: (team: BallFlowTeam, rounds: Int)?
        
        for (team, rounds) in wonRounds {
            if let safeMaxRoundsTeam = maxRoundsTeam, safeMaxRoundsTeam.rounds < rounds {
                maxRoundsTeam = (team, rounds)
            } else {
                maxRoundsTeam = (team, rounds)
            }
        }
        
        return maxRoundsTeam
    }
    
    func beginNextRound(ofGame gameType: GameType) {
        if let currentRound = self.currentRound {
            oldRounds.append(currentRound)
            if let teamWithMorePoints = self.currentRound?.teamWithMorePoints() {
                addWonRound(toTeam: teamWithMorePoints.team)
            }
        }
        
        currentRound = Round.init(withGameType: gameType)
    }

    func newPoints(_ points: Int, toTeam team: BallFlowTeam) -> Int? {
        return currentRound?.addPoints(points, toTeam: team)
    }
}
