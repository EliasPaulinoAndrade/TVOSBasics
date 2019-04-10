//
//  FLTextField.swift
//  TVOSBasics
//
//  Created by Levy Cristian  on 09/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class FLTextField: UITextField {

    init(frame: CGRect, placeholder: String) {
        super.init(frame: frame)
        self.placeholder = placeholder
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        self.backgroundColor = .white
    
    }
    
}

extension FLTextField{
    override internal func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        if context.nextFocusedView == self {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                self.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
                self.setShadow()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                self.transform = CGAffineTransform.identity
                self.layer.shadowColor = UIColor.clear.cgColor
                self.isOpaque = false
            }, completion: nil)
        }
    }
    
    private func setShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.5
        
    }
    
}
