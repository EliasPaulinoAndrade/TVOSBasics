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
    var currentRound = 0
    var gameType: GameType
    
    init(_ gameType: GameType, withNumberOfRounds numberOfRounds: Int) {
        self.numberOfRounds = numberOfRounds
        self.gameType = gameType
    }
    
    func hasMoreRounds() -> Bool {
        
        if currentRound + 1 < numberOfRounds {
            return true
        } else {
            return false
        }
    }
}
