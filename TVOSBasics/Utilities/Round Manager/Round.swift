//
//  Round.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class Round {
    var teamScores: [BallFlowTeam: Int] = [:]
    var gameType: GameType
    
    init(withGameType gameType: GameType) {

        self.gameType = gameType
    }
    
    func addPoints(_ points: Int, toTeam team: BallFlowTeam) -> Int {
        
        if let teamScore = self.teamScores[team] {
            self.teamScores[team] = teamScore + points
            return teamScore + points
        } else {
            teamScores[team] = points
            return points
        }
    }
    
    func teamWithMorePoints() -> (team: BallFlowTeam, points: Int)? {
        
        var maxPointsTeam: (team: BallFlowTeam, points: Int)?
        
        for (team, points) in teamScores {
            if let safeMaxPointsTeam = maxPointsTeam, safeMaxPointsTeam.points < points {
                maxPointsTeam = (team, points)
            } else {
                maxPointsTeam = (team, points)
            }
        }
        
        return maxPointsTeam
    }
}
