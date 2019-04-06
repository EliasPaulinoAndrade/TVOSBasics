//
//  BallFlowTeam.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

enum Team: String, CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
    
    case red, blue
}
