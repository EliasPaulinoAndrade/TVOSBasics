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
    
    lazy var contentTextLabel: UILabel = {
        let contentTextLabel = UILabel.init()
        
        contentTextLabel.textAlignment = .center
        contentTextLabel.font = UIFont.systemFont(ofSize: 50)
        
        return contentTextLabel
    }()
    
    lazy var backgroundView: UIView = {
        let backgroundView = UIView.init()
        
        backgroundView.backgroundColor = UIColor.black
        backgroundView.layer.opacity = 0.5
        
        return backgroundView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView.init()
        
        contentView.backgroundColor = UIColor.white
        
        return contentView
    }()
    
    init(text: String, completion: (() -> ())? = nil) {
        self.completion = completion
        
        super.init(frame: CGRect.zero)
        
        contentTextLabel.text = text
        addSubview(backgroundView)
        addSubview(contentView)
        contentView.addSubview(contentTextLabel)
        
        setupInput()
    }
    
    func reset(withText text: String, completion: (() -> ())? = nil) {
        self.completion = completion
        
        self.contentTextLabel.text = text
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
        contentTextLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            constraints(toFill: superview) +
            backgroundView.constraints(toFill: self) +
            contentView.constraints(toFill: self, margin: 100) +
            contentTextLabel.constraints(toFill: contentView, margin: 20)
        )
    }
}
