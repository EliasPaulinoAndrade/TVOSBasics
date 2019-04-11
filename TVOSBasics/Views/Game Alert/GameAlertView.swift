//
//  GameAlertView.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit

/// a simple alert with text, and need to tap play/pause to close
class GameAlertView: UIView {
    
    var completion: (() -> ())?
    
    weak var datasource: GameAlertViewDatasource?
    
    lazy var backgroundView: UIView = {
        let backgroundView = UIView.init()
        
        backgroundView.backgroundColor = UIColor.black
        backgroundView.layer.opacity = 0.7
        
        return backgroundView
    }()
    
    lazy var contentView: UIView = {
        let contentView = ScoreShadowView.init(withBorderColor: UIColor.flDarkYellow)
        
        contentView.backgroundColor = UIColor.white
        
        return contentView
    }()
    
    lazy var middleTitleSpace: UIView = {
        let middleTitleSpace = ScoreShadowView.init(withBorderColor: UIColor.flDarkYellow)
        
        middleTitleSpace.backgroundColor = UIColor.flYellow
        
        return middleTitleSpace
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        
        titleLabel.text = "..."
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    lazy var topWire = DoubleWireView.init(wireHeight: 50, verticalCenter: -530, prefferedWidthAnchor: middleTitleSpace.widthAnchor)
    
    init(withTitle title: String, completion: (() -> ())? = nil) {
        self.completion = completion
        
        super.init(frame: CGRect.zero)
        
        titleLabel.text = title
        
        addSubview(backgroundView)
        addSubview(contentView)
        
        addSubview(middleTitleSpace)
        middleTitleSpace.addSubview(titleLabel)
        addSubview(topWire)
        
        setupInput()
    }
    
    func reset(completion: (() -> ())? = nil) {
        self.completion = completion
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.opacity = 1
        })
    }
    
    func setupInput() {
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(playWasTapped(tapGestureRecognizer:)))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.playPause.rawValue)]
        self.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func playWasTapped(tapGestureRecognizer: UITapGestureRecognizer) {
   
        UIView.animate(withDuration: 0.3, animations: {
            self.layer.opacity = 0
        }) { (_) in
            self.isHidden = true
            self.completion?()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        guard let superview = self.superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        middleTitleSpace.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            constraints(toFill: superview) +
            backgroundView.constraints(toFill: self) +
            titleLabel.constraints(toFill: middleTitleSpace, margin: 20) + [
                
            contentView.topAnchor.constraint(equalTo: middleTitleSpace.bottomAnchor, constant: 100),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -800),
            
            middleTitleSpace.topAnchor.constraint(equalTo: superview.topAnchor, constant: 20),
            middleTitleSpace.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -800),
            middleTitleSpace.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            middleTitleSpace.heightAnchor.constraint(equalToConstant: 100)
            ]
        )
        
        if let contentSubView = datasource?.contentView() {
            contentView.addSubview(contentSubView)
            
            contentSubView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate(contentSubView.constraints(toFill: contentView))
            
        }
    }
}
