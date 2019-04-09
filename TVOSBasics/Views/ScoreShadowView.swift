//
//  ScoreShadowView.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit


class ScoreShadowView: UIView {
    init(withBorderColor borderColor: UIColor) {
        super.init(frame: CGRect.zero)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3
        clipsToBounds = false
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.init(width: 0, height: 5)
        
        layer.borderWidth = 5
        layer.borderColor = borderColor.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
