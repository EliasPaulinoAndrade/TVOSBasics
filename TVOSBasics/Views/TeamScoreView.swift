//
//  TeamScoreView.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit

/// the individual team score space
class TeamScoreView: UIView {
    
    var showTurnLabel: Bool
    var alignLeft: Bool
    
    lazy var teamNameLabel: UILabel = {
        let teamNameLabel = UILabel.init()
        
        teamNameLabel.text = "Red"
        teamNameLabel.numberOfLines = 1
        
        if alignLeft {
            teamNameLabel.textAlignment = .left
        } else {
            teamNameLabel.textAlignment = .right
        }
        
        return teamNameLabel
    }()
    
    lazy var turnNameLabel: UILabel = {
        let turnNameLabel = UILabel.init()
        
        turnNameLabel.text = "Your Turn"
        turnNameLabel.numberOfLines = 1
        turnNameLabel.textAlignment = .center
        
        return turnNameLabel
    }()
    
    lazy var turnLabelSpace: UIView = {
        let turnLabelSpace = ScoreShadowView.init()
        
        turnLabelSpace.backgroundColor = UIColor.flLightYellow
        turnLabelSpace.layer.borderWidth = 5
        turnLabelSpace.layer.borderColor = UIColor.flDarkYellow.cgColor
        if !showTurnLabel {
            turnLabelSpace.isHidden = true
        }
        
        return turnLabelSpace
    }()
    
    lazy var teamScoresSpace: UIView = {
        let teamScoresSpace = ScoreShadowView.init()
        
        teamScoresSpace.backgroundColor = UIColor.flYellow
        teamScoresSpace.layer.borderWidth = 5
        teamScoresSpace.layer.borderColor = UIColor.flDarkYellow.cgColor
        
        return teamScoresSpace
    }()
    
    init(teamName: String, showTurnLabel: Bool = false, alignLeft: Bool = false) {
        
        self.showTurnLabel = showTurnLabel
        self.alignLeft = alignLeft
        
        super.init(frame: CGRect.zero)
        
        teamNameLabel.text = teamName

        addSubview(teamScoresSpace)
        addSubview(turnLabelSpace)
        
        teamScoresSpace.addSubview(teamNameLabel)
        turnLabelSpace.addSubview(turnNameLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        turnNameLabel.translatesAutoresizingMaskIntoConstraints = false
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        turnLabelSpace.translatesAutoresizingMaskIntoConstraints = false
        teamScoresSpace.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            teamNameLabel.constraints(toTopFill: teamScoresSpace, margin: 20) +
            turnNameLabel.constraints(toFill: turnLabelSpace) +
            teamScoresSpace.constraints(toTopFill: self) +
            turnLabelSpace.constraints(toBottomFill: self) + [
                turnLabelSpace.topAnchor.constraint(equalTo: teamScoresSpace.bottomAnchor, constant: 10),
                turnLabelSpace.heightAnchor.constraint(equalToConstant: 70)
            ]
        )
    }
}
