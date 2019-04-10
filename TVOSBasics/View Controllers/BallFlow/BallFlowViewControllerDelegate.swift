//
//  BallFlowViewControllerDelegate.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 09/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit

protocol BallFlowViewControllerDelegate {
    func gameDidFinished(withGameController gameController: GameController?)
}
