//
//  InputAlertView.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 09/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit

private class ContainerView: UIView {
    lazy var contentTextLabel: UILabel = {
        let contentTextLabel = UILabel.init()
        
        contentTextLabel.textAlignment = .left
        contentTextLabel.font = UIFont.systemFont(ofSize: 50)
        
        return contentTextLabel
    }()
    
    lazy var textInputView: UITextField = {
        let textInputView = UITextField.init()
        
        
        return textInputView
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        addSubview(contentTextLabel)
        addSubview(textInputView)
    }
    
    override func didMoveToWindow() {
        contentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            contentTextLabel.constraints(toTopFill: self, margin: 50) +
            textInputView.constraints(toHorizontalFill: self, margin: 50) + [
            textInputView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textInputView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InputGameAlert {
    
    var completion: (() -> ())?
    
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
    
    init(withAlertTitle alertTitle: String, inputTitle: String, completion: (() -> ())?) {
        self.alertTitle = alertTitle
        self.completion = completion
        containerView.contentTextLabel.text = inputTitle
    }
}

extension InputGameAlert: GameAlertViewDatasource {
    func contentView() -> UIView {
        return containerView
    }
}
