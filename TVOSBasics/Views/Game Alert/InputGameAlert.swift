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
        
        contentTextLabel.textAlignment = .center
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
            contentTextLabel.constraints(toTopFill: self) +
            textInputView.constraints(toVerticalFill: self) + [
            textInputView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InputGameAlert {
    
    var completion: (() -> ())?

    private var containerView = ContainerView.init()
    
    lazy var gameAlertView: GameAlertView = {
        let gameAlertView = GameAlertView(){
            self.completion?()
        }
        
        gameAlertView.datasource = self
        
        return gameAlertView
    }()
    
    init(withInputTitle inputTitle: String, completion: (() -> ())?) {
        self.completion = completion
        containerView.contentTextLabel.text = inputTitle
    }
}

extension InputAlertView: GameAlertViewDatasource {
    func contentView() -> UIView {
        return containerView
    }
}
