//
//  FLButton.swift
//  TVOSBasics
//
//  Created by Levy Cristian  on 09/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class FLButton: UIButton {
   
    init(frame: CGRect, name: String) {
        super.init(frame: frame)
        self.setTitle(name, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = UIColor.flYellow
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.flDarkYellow.cgColor

    }

}

extension FLButton{
    override internal func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        if context.nextFocusedView == self {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
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
