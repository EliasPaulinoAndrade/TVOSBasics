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
    
    var showTurnLabel: Bool {
        didSet {
            if showTurnLabel {
                turnLabelSpace.isHidden = false
                middleWire.isHidden = false
            } else {
                turnLabelSpace.isHidden = true
                middleWire.isHidden = true
            }
        }
    }
    
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
    
    lazy var middleWire: DoubleWireView = {
        let middleWire = DoubleWireView.init(wireHeight: 30, verticalCenter: 50)
        
        if !showTurnLabel {
            middleWire.isHidden = true
        }
        
        return middleWire
    }()
    
    lazy var scoreImageView: UIImageView = {
        let scoreImageView = UIImageView.init()
        
        scoreImageView.image = UIImage.init(named: "score")
        scoreImageView.contentMode = .scaleAspectFit
        
        return scoreImageView
    }()
    
    lazy var scoreLabel: UILabel = {
        let scoreLabel = UILabel.init()
        
        scoreLabel.text = "0"
        scoreLabel.numberOfLines = 1
        scoreLabel.font = UIFont.systemFont(ofSize: 30)
        
        return scoreLabel
    }()
    
    lazy var medalImageView: UIImageView = {
        let medalImageView = UIImageView.init()
        
        medalImageView.image = UIImage.init(named: "silverMedal")
        medalImageView.contentMode = .scaleAspectFit
        
        return medalImageView
    }()
    
    lazy var medalLabel: UILabel = {
        let medalLabel = UILabel.init()
        
        medalLabel.text = "0"
        medalLabel.numberOfLines = 1
        medalLabel.font = UIFont.systemFont(ofSize: 30)
        
        return medalLabel
    }()
    
    var topWire = DoubleWireView.init(wireHeight: 80, verticalCenter: -155)
    
    func scoreImageRotateAnimation() {
        
        let scaleTransform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        let rotateTransform = CGAffineTransform.init(rotationAngle: 180)
        let scaleAndRotateTransform = scaleTransform.concatenating(rotateTransform)
        
        let scaleBackTransform = CGAffineTransform.init(scaleX: 1, y: 1)
        let rotateBackTransform = CGAffineTransform.init(rotationAngle: 0)
        let scaleBackAndRotateTransform = scaleBackTransform.concatenating(rotateBackTransform)
        
        UIView.animate(withDuration: 1, animations: {
            self.scoreImageView.transform = scaleAndRotateTransform
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.scoreImageView.transform = scaleBackAndRotateTransform
            })
        }
    }
    
    init(teamName: String, showTurnLabel: Bool = false, alignLeft: Bool = false) {
        
        self.showTurnLabel = showTurnLabel
        self.alignLeft = alignLeft
        
        super.init(frame: CGRect.zero)
        
        teamNameLabel.text = teamName

        addSubview(teamScoresSpace)
        addSubview(turnLabelSpace)
        addSubview(middleWire)
        addSubview(topWire)
        
        teamScoresSpace.addSubview(teamNameLabel)
        teamScoresSpace.addSubview(scoreImageView)
        teamScoresSpace.addSubview(medalImageView)
        teamScoresSpace.addSubview(scoreLabel)
        teamScoresSpace.addSubview(medalLabel)
        
        turnLabelSpace.addSubview(turnNameLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        medalLabel.translatesAutoresizingMaskIntoConstraints = false
        turnNameLabel.translatesAutoresizingMaskIntoConstraints = false
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        turnLabelSpace.translatesAutoresizingMaskIntoConstraints = false
        scoreImageView.translatesAutoresizingMaskIntoConstraints = false
        medalImageView.translatesAutoresizingMaskIntoConstraints = false
        teamScoresSpace.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            teamNameLabel.constraints(toTopFill: teamScoresSpace, margin: 20) +
            turnNameLabel.constraints(toFill: turnLabelSpace) +
            teamScoresSpace.constraints(toTopFill: self) +
            turnLabelSpace.constraints(toBottomFill: self) + [
                turnLabelSpace.topAnchor.constraint(equalTo: teamScoresSpace.bottomAnchor, constant: 10),
                turnLabelSpace.heightAnchor.constraint(equalToConstant: 70),
                
                scoreImageView.widthAnchor.constraint(equalToConstant: 70),
                scoreImageView.heightAnchor.constraint(equalToConstant: 70),
                scoreImageView.bottomAnchor.constraint(equalTo: teamScoresSpace.bottomAnchor, constant: -20),
                scoreImageView.leftAnchor.constraint(equalTo: teamScoresSpace.leftAnchor, constant: 20),
                scoreLabel.centerYAnchor.constraint(equalTo: scoreImageView.centerYAnchor),
                scoreLabel.leftAnchor.constraint(equalTo: scoreImageView.rightAnchor, constant: 20),
                
                medalImageView.widthAnchor.constraint(equalToConstant: 70),
                medalImageView.heightAnchor.constraint(equalToConstant: 70),
                medalImageView.leftAnchor.constraint(equalTo: scoreLabel.rightAnchor, constant: 20),
                medalImageView.bottomAnchor.constraint(equalTo: teamScoresSpace.bottomAnchor, constant: -20),
                medalLabel.leftAnchor.constraint(equalTo: medalImageView.rightAnchor, constant: 20),
                medalLabel.centerYAnchor.constraint(equalTo: medalImageView.centerYAnchor),
                medalLabel.rightAnchor.constraint(equalTo: teamScoresSpace.rightAnchor, constant: -20),
                medalLabel.widthAnchor.constraint(equalToConstant: 50)
            ]
        )
    }
}
