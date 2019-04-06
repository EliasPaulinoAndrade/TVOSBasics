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
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3
        clipsToBounds = false
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.init(width: 0, height: 5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
