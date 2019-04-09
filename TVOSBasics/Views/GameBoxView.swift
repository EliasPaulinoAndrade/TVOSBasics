//
//  GameBoxView.swift
//  TVOSBasics
//
//  Created by Cibele Paulino on 09/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit

class GameBoxView: UIView {
    var image: UIImage?
    var name: String
    override var canBecomeFocused: Bool {
        return true
    }
    
    lazy var boxImageView: UIView = {
        var view = UIView()
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.7
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.borderWidth = 7.0
        view.layer.borderColor = UIColor.flDarkYellow.cgColor
        
        return view
    }()
    
    lazy var imageGameView: UIImageView = {
        
        var imageView = UIImageView.init(image: image)
        
        return imageView
    }()
    
    lazy var titleGameView: UIView = {
        var boxTitle = UIView()
        boxTitle.layer.shadowColor = UIColor.black.cgColor
        boxTitle.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        boxTitle.layer.masksToBounds = false
        boxTitle.layer.shadowRadius = 2.0
        boxTitle.layer.shadowOpacity = 0.7
        boxTitle.layer.cornerRadius = boxTitle.frame.width / 2
        boxTitle.backgroundColor = UIColor.flLightYellow
        boxTitle.layer.borderWidth = 7.0
        boxTitle.layer.borderColor = UIColor.flDarkYellow.cgColor
        
        return boxTitle
    }()
    
    lazy var titleGameLabel: UILabel = {
        var label = UILabel()
        label.text = name
        
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var middleWire = DoubleWireView.init(wireHeight: 35, verticalCenter: 90, prefferedWidthAnchor: titleGameView.widthAnchor)
    
    init(image: UIImage?, name: String) {
        self.image = image
        self.name = name
        
        super.init(frame: CGRect.zero)
        
        self.addSubview(titleGameView)
        self.addSubview(boxImageView)
        self.addSubview(middleWire)
        
        self.titleGameView.addSubview(titleGameLabel)
        self.boxImageView.addSubview(imageGameView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        
        boxImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            boxImageView.constraints(toTopFill: self) + [
                boxImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7)
            ]
        )
    
        imageGameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageGameView.topAnchor.constraint(equalTo: boxImageView.topAnchor, constant: 0),
            imageGameView.bottomAnchor.constraint(equalTo: boxImageView.bottomAnchor, constant: 0),
            imageGameView.rightAnchor.constraint(equalTo: boxImageView.rightAnchor, constant: 0),
            imageGameView.leftAnchor.constraint(equalTo: boxImageView.leftAnchor, constant: 0)
        ])
        
        titleGameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            titleGameView.constraints(toBottomFill: self, margin: 10) + [
                titleGameView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3, constant: -20)
            ]
        )
        
        titleGameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleGameLabel.centerXAnchor.constraint(equalTo: titleGameView.centerXAnchor, constant: 0),
            titleGameLabel.centerYAnchor.constraint(equalTo: titleGameView.centerYAnchor, constant: 0)
        ])
    }
    
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.layer.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
            }, completion: nil)
        } else if context.previouslyFocusedView == self {
            coordinator.addCoordinatedAnimations({ () -> Void in
                self.layer.backgroundColor = UIColor.clear.cgColor
            }, completion: nil)
        }
    }
}

