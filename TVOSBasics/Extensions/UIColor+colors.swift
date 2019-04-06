//
//  UIColor+colors.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static var flDefault: UIColor {
        return UIColor.black
    }
    
    static var flGreen: UIColor {
        return UIColor.init(named: "flGreen") ?? UIColor.flDefault
    }
    
    static var flBlue: UIColor {
        return UIColor.init(named: "flBlue") ?? UIColor.flDefault
    }
    
    static var flPink: UIColor {
        return UIColor.init(named: "flPink") ?? UIColor.flDefault
    }
}
