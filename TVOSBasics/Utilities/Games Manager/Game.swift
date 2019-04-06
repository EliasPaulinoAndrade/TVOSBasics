//
//  Game.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class Game {
    var numberOfRounds: Int
    var currentRound: Int?
    var gameType: GameType
    
    init(_ gameType: GameType, withNumberOfRounds numberOfRounds: Int) {
        self.numberOfRounds = numberOfRounds
        self.gameType = gameType
    }
    
    func hasMoreRounds() -> Bool {
        if let currentRound = self.currentRound {
            if numberOfRounds - currentRound >= 1 {
                return true
            } else {
                return false
            }
        } else if numberOfRounds > 0 {
            return true
        }

        return true
    }
}
