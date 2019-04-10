//
//  TextualGameAlertView.swift
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
        contentTextLabel.font = UIFont.systemFont(ofSize: 40)
        contentTextLabel.text = "..."
        
        return contentTextLabel
    }()
    
    lazy var titleContentLabel: UILabel = {
        let titleContentLabel = UILabel.init()
        
        titleContentLabel.textAlignment = .center
        titleContentLabel.font = UIFont.boldSystemFont(ofSize: 50)
        titleContentLabel.text = "..."
        
        return titleContentLabel
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        addSubview(contentTextLabel)
        addSubview(titleContentLabel)
    }
    
    override func didMoveToWindow() {
        contentTextLabel.translatesAutoresizingMaskIntoConstraints = false
        titleContentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            titleContentLabel.constraints(toTopFill: self, margin: 50) +
            contentTextLabel.constraints(toHorizontalFill: self, margin: 50) + [
                contentTextLabel.topAnchor.constraint(equalTo: titleContentLabel.bottomAnchor, constant: 50)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TextualGameAlert {
    
    var alertTitle: String {
        didSet {
            self.gameAlertView.titleLabel.text = alertTitle
        }
    }
    
    var completion: (() -> ())?
    
    private var containerView = ContainerView.init()
    
    lazy var gameAlertView: GameAlertView = {
        let gameAlertView = GameAlertView(withTitle: self.alertTitle){
            self.completion?()
        }
        
        gameAlertView.datasource = self
        
        return gameAlertView
    }()
    
    init(withAlertTitle alertTitle: String, text: String, andContentTitle contentTitle: String, completion: (() -> ())?) {
        self.completion = completion
        self.alertTitle = alertTitle
        containerView.titleContentLabel.text = contentTitle
        containerView.contentTextLabel.text = text
    }
    
    func reset(withTitle title: String, andText text: String, completion: (() -> ())? = nil) {
        containerView.titleContentLabel.text = title
//        containerView.contentTextLabel.text = text
//        self.gameAlertView.completion = completion
        self.gameAlertView.reset(withText: text, completion: completion)
    }
}

extension TextualGameAlert: GameAlertViewDatasource {
    func contentView() -> UIView {
        return containerView
    }
}
