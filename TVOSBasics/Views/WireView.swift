//
//  WireView.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class WireView: UIView {
    
    var wireHeight: CGFloat
    
    var verticalCenter: CGFloat
    
    var prefferedWidthAnchor: NSLayoutDimension?
    
    var firstWire = UIView.init()
    
    var secondWire = UIView.init()

    init(wireHeight: CGFloat, verticalCenter: CGFloat, prefferedWidthAnchor: NSLayoutDimension? = nil) {
        
        self.wireHeight = wireHeight
        self.verticalCenter = verticalCenter
        self.prefferedWidthAnchor = prefferedWidthAnchor
        
        super.init(frame: CGRect.zero)
        
        addSubview(firstWire)
        addSubview(secondWire)
        
        firstWire.backgroundColor = UIColor.black
        secondWire.backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        guard let superview = self.superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        firstWire.translatesAutoresizingMaskIntoConstraints = false
        secondWire.translatesAutoresizingMaskIntoConstraints = false
        
        var viewsConstraints =
            firstWire.constraints(toVerticalFill: self) +
            secondWire.constraints(toVerticalFill: self) + [
                heightAnchor.constraint(equalToConstant: wireHeight),
                centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: verticalCenter),
                firstWire.widthAnchor.constraint(equalToConstant: 5),
                secondWire.widthAnchor.constraint(equalToConstant: 5),
                firstWire.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                secondWire.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        ]
        
        if let prefferedWidthAnchor = prefferedWidthAnchor {
            let prefferedWidthConstraint = widthAnchor.constraint(equalTo: prefferedWidthAnchor)
            let centerXConstraint = centerXAnchor.constraint(equalTo: superview.centerXAnchor)
            viewsConstraints += [prefferedWidthConstraint, centerXConstraint]
        } else {
            viewsConstraints += constraints(toHorizontalFill: superview)
        }
        
        NSLayoutConstraint.activate(viewsConstraints)
    }
}
