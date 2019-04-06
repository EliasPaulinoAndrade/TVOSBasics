//
//  ScoreBoardView.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit


/// A view responsible by show the teams scores
class ScoreBoardView: UIView {
    
    var redTeamPlaceView = TeamScoreView.init(teamName: "Red", showTurnLabel: true, alignLeft: true)
    
    var blueTeamPlaceView = TeamScoreView.init(teamName: "Blue")
    
    lazy var middlePlaceView: UIView = {
        let middlePlaceView = UIView.init()
        
        return middlePlaceView
    }()
    
    lazy var middleTitleSpace: UIView = {
        let middleTitleSpace = ScoreShadowView.init()
        
        middleTitleSpace.backgroundColor = UIColor.flYellow
        middleTitleSpace.layer.borderWidth = 5
        middleTitleSpace.layer.borderColor = UIColor.flDarkYellow.cgColor
        
        return middleTitleSpace
    }()
    
    lazy var middleRoundSpace: UIView = {
        let middleRoundSpace = ScoreShadowView.init()
        
        middleRoundSpace.backgroundColor = UIColor.flLightYellow
        middleRoundSpace.layer.borderWidth = 5
        middleRoundSpace.layer.borderColor = UIColor.flDarkYellow.cgColor
        
        return middleRoundSpace
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        
        titleLabel.text = "Paper Plate Targets"
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    lazy var roundLabel: UILabel = {
        let roundLabel = UILabel.init()
        
        roundLabel.text = "Round 2 of 3"
        roundLabel.textAlignment = .center
        
        return roundLabel
    }()
    
    lazy var middleWire = DoubleWireView.init(wireHeight: 30, verticalCenter: -30, prefferedWidthAnchor: middleRoundSpace.widthAnchor)
    
    lazy var topWire = DoubleWireView.init(wireHeight: 80, verticalCenter: -155, prefferedWidthAnchor: middleRoundSpace.widthAnchor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(redTeamPlaceView)
        addSubview(middlePlaceView)
        addSubview(blueTeamPlaceView)
        
        middlePlaceView.addSubview(middleTitleSpace)
        middlePlaceView.addSubview(middleRoundSpace)
        
        middleTitleSpace.addSubview(titleLabel)
        middleRoundSpace.addSubview(roundLabel)
        
        middlePlaceView.addSubview(middleWire)
        middlePlaceView.addSubview(topWire)
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
        middleTitleSpace.translatesAutoresizingMaskIntoConstraints = false
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        middleRoundSpace.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            constraints(toTopFill: superViewMargins) + [
            heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate(
            redTeamPlaceView.constraints(toLeftFill: self) + [
            redTeamPlaceView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate(
            blueTeamPlaceView.constraints(toRightFill: self) + [
            blueTeamPlaceView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate(
            middlePlaceView.constraints(toVerticalFill: self) + [
            middlePlaceView.rightAnchor.constraint(equalTo: blueTeamPlaceView.leftAnchor),
            middlePlaceView.leftAnchor.constraint(equalTo: redTeamPlaceView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate(
            titleLabel.constraints(toFill: middleTitleSpace, margin: 20) + [
            middleTitleSpace.topAnchor.constraint(equalTo: middlePlaceView.topAnchor),
            middleTitleSpace.heightAnchor.constraint(equalToConstant: 90),
            middleTitleSpace.widthAnchor.constraint(lessThanOrEqualTo: middlePlaceView.widthAnchor, constant: -20),
            middleTitleSpace.centerXAnchor.constraint(equalTo: middlePlaceView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate(
            roundLabel.constraints(toFill: middleRoundSpace, margin: 20) + [
            middleRoundSpace.topAnchor.constraint(equalTo: middleTitleSpace.bottomAnchor, constant: 10),
            middleRoundSpace.heightAnchor.constraint(equalToConstant: 90),
            middleRoundSpace.widthAnchor.constraint(lessThanOrEqualTo: middleTitleSpace.widthAnchor),
            middleRoundSpace.centerXAnchor.constraint(equalTo: middlePlaceView.centerXAnchor)
        ])
    }
}

