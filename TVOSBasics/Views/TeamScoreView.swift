//
//  TeamScoreView.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit

class TeamScoreView: UIView {
    
    lazy var teamNameLabel: UILabel = {
        let teamNameLabel = UILabel.init()
        
        teamNameLabel.text = "Red"
        teamNameLabel.numberOfLines = 1
        teamNameLabel.textAlignment = .center
        
        return teamNameLabel
    }()
    
    init(teamName: String) {
        super.init(frame: CGRect.zero)
        
        teamNameLabel.text = teamName
        addSubview(teamNameLabel)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            teamNameLabel.constraints(toTopFill: self, margin: 15)
        )
    }
}
