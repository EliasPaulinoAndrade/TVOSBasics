//
//  UIView+fillConstraints.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    //view fill constraints
    func constraints(toFill view: UIView, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraints(toVerticalFill: view, margin: margin) + constraints(toHorizontalFill: view, margin: margin)
    }
    
    func constraints(toVerticalFill view: UIView, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin)
        ]
    }
    
    func constraints(toHorizontalFill view: UIView, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin)
        ]
    }
    
    func constraints(toTopFill view: UIView, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraints(toHorizontalFill: view, margin: margin) + [
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: margin)
        ]
    }
    
    func constraints(toBottomFill view: UIView, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraints(toHorizontalFill: view, margin: margin) + [
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin)
        ]
    }
    
    func constraints(toLeftFill view: UIView, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraints(toVerticalFill: view, margin: margin) + [
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin)
        ]
    }
    
    func constraints(toRightFill view: UIView, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraints(toVerticalFill: view, margin: margin) + [
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin)
        ]
    }
    
    //margin fill constraints
    func constraints(toFill view: UILayoutGuide, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraints(toVerticalFill: view, margin: margin) + constraints(toHorizontalFill: view, margin: margin)
    }
    
    func constraints(toVerticalFill view: UILayoutGuide, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin)
        ]
    }
    
    func constraints(toHorizontalFill view: UILayoutGuide, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin)
        ]
    }
    
    func constraints(toTopFill view: UILayoutGuide, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraints(toHorizontalFill: view, margin: margin) + [
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: margin)
        ]
    }
    
    func constraints(toBottomFill view: UILayoutGuide, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraints(toHorizontalFill: view, margin: margin) + [
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin)
        ]
    }
    
    func constraints(toLeftFill view: UILayoutGuide, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraints(toVerticalFill: view, margin: margin) + [
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin)
        ]
    }
    
    func constraints(toRightFill view: UILayoutGuide, margin: CGFloat = 0) -> [NSLayoutConstraint] {
        return constraints(toVerticalFill: view, margin: margin) + [
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin)
        ]
    }
}
