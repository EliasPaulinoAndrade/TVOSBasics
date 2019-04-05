//
//  ScoreBoardView.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class ScoreBoardView: UIView {
    
    lazy var redTeamPlaceView: TeamScoreView = {
        let redTeamPlaceView = TeamScoreView.init(teamName: "Red")
        
        redTeamPlaceView.backgroundColor = UIColor.red
        
        return redTeamPlaceView
    }()
    
    lazy var blueTeamPlaceView: TeamScoreView = {
        let blueTeamPlaceView = TeamScoreView.init(teamName: "Blue")
        
        blueTeamPlaceView.backgroundColor = UIColor.blue
        
        return blueTeamPlaceView
    }()
    
    lazy var middlePlaceView: UIView = {
        let middlePlaceView = UIView.init()
        
        return middlePlaceView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        
        titleLabel.text = "Round 2 of 3"
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(redTeamPlaceView)
        addSubview(middlePlaceView)
        addSubview(blueTeamPlaceView)
        
        middlePlaceView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        guard let superView = superview else {
            return
        }
        
        let superViewMargins = superView.layoutMarginsGuide
        
        translatesAutoresizingMaskIntoConstraints = false
        redTeamPlaceView.translatesAutoresizingMaskIntoConstraints = false
        middlePlaceView.translatesAutoresizingMaskIntoConstraints = false
        blueTeamPlaceView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            constraints(toTopFill: superViewMargins) + [
            heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate(
            redTeamPlaceView.constraints(toLeftFill: self) + [
            redTeamPlaceView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25)
        ])
        
        NSLayoutConstraint.activate(
            blueTeamPlaceView.constraints(toRightFill: self) + [
            blueTeamPlaceView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25)
        ])
        
        NSLayoutConstraint.activate(
            middlePlaceView.constraints(toVerticalFill: self) + [
            middlePlaceView.rightAnchor.constraint(equalTo: blueTeamPlaceView.leftAnchor),
            middlePlaceView.leftAnchor.constraint(equalTo: redTeamPlaceView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate(
            titleLabel.constraints(toFill: middlePlaceView)
        )
    }
}
