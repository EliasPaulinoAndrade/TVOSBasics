//
//  Round.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class Round {
    var teamScores: [Team: Int] = [:]
    var gameType: GameType
    var currentTeam: Team?
    var teamRoundCounter = 0
    var numberOfTeams: Int
    
    init(withGameType gameType: GameType, beginByTeam team: Team, andNumberOfTeams numberOfTeams: Int) {

        self.gameType = gameType
        self.currentTeam = team
        self.numberOfTeams = numberOfTeams
    }
    
    func changeTeamTo(_ team: Team) -> Bool {
        guard teamRoundCounter + 1 < numberOfTeams else {
            return false
        }
        
        self.currentTeam = team
        teamRoundCounter += 1
        
        return true
    }
    
    func addPoints(_ points: Int) -> Int {
        
        guard let currentTeam = self.currentTeam else {
            return -1
        }
        
        if let teamScore = self.teamScores[currentTeam] {
            self.teamScores[currentTeam] = teamScore + points
            return teamScore + points
        } else {
            teamScores[currentTeam] = points
            return points
        }
    }
    
    func teamWithMorePoints() -> (team: Team, points: Int)? {
        
        var maxPointsTeam: (team: Team, points: Int)?
        
        for (team, points) in teamScores {
            if let safeMaxPointsTeam = maxPointsTeam {
                if  safeMaxPointsTeam.points < points {
                    maxPointsTeam = (team, points)
                }
            } else {
                maxPointsTeam = (team, points)
            }
        }
        
        return maxPointsTeam
    }
}
