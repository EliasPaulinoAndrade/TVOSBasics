//
//  ConfirmGameAlert.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 09/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit

private class ContainerView: UIView {
    
    var completion: (()->())?
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    lazy var contentTextLabel: UILabel = {
        let contentTextLabel = UILabel.init()
        
        contentTextLabel.textAlignment = .center
        contentTextLabel.font = UIFont.systemFont(ofSize: 50)
        contentTextLabel.text = "bla bla bla "
        
        return contentTextLabel
    }()
    
    lazy var confirmButton: UIView = {
        let confirmButton = ScoreShadowView.init(withBorderColor: UIColor.flYellow)
        
        confirmButton.backgroundColor = UIColor.flLightYellow
        
        return confirmButton
    }()
    
    lazy var confirmLabel: UILabel = {
        let confirmLabel = UILabel.init()
        
        confirmLabel.text = "..."
        confirmLabel.textAlignment = .center
        
        return confirmLabel
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        addSubview(contentTextLabel)
        addSubview(confirmButton)
        confirmButton.addSubview(confirmLabel)
        
        let buttonTapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(buttonWasTapped(gestureRecognizer:)))
        buttonTapRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.select.rawValue)]
        
        addGestureRecognizer(buttonTapRecognizer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonWasTapped(gestureRecognizer: UITapGestureRecognizer) {
        completion?()
    }
    
    override func didMoveToSuperview() {
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmLabel.translatesAutoresizingMaskIntoConstraints = false
        contentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            confirmLabel.constraints(toFill: confirmButton, margin: 10) +
            contentTextLabel.constraints(toTopFill: self, margin: 50) + [
                confirmButton.widthAnchor.constraint(equalToConstant: 300),
                confirmButton.heightAnchor.constraint(equalToConstant: 100),
                confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                confirmButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ]
        )
    }
}

class ConfirmGameAlert {
    
    var completion: (() -> ())? {
        didSet {
            gameAlertView.completion = completion
        }
    }
    
    var confirmCompletion: (() -> ())? {
        didSet {
            containerView.completion = confirmCompletion
        }
    }
    
    var alertTitle: String {
        didSet {
            self.gameAlertView.titleLabel.text = alertTitle
        }
    }
    
    private var containerView = ContainerView.init()
    
    lazy var gameAlertView: GameAlertView = {
        let gameAlertView = GameAlertView(withTitle: self.alertTitle){
            self.completion?()
        }
        
        gameAlertView.datasource = self
        
        return gameAlertView
    }()
    
    init(withAlertTitle alertTitle: String, buttonText: String, contentTitle: String, playCompletion: (() -> ())? = nil, confirmCompletion: (() -> ())? = nil) {
        
        self.alertTitle = alertTitle
        self.completion = playCompletion
        
        containerView.completion = confirmCompletion
        containerView.confirmLabel.text = buttonText
        containerView.contentTextLabel.text = contentTitle
    }
}

extension ConfirmGameAlert: GameAlertViewDatasource {
    func contentView() -> UIView {
        return containerView
    }
}
