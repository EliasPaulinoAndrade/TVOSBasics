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
    
    static var flYellow: UIColor {
        return UIColor.init(named: "flYellow") ?? UIColor.flDefault
    }
    
    static var flLightYellow: UIColor {
        return UIColor.init(named: "flLightYellow") ?? UIColor.flDefault
    }
    
    static var flDarkYellow: UIColor {
        return UIColor.init(named: "flDarkYellow") ?? UIColor.flDefault
    }
    
    static var flLightBlue: UIColor {
        return UIColor.init(named: "flLightBlue") ?? UIColor.flDefault
    }
    
    static var flGrayBlue: UIColor {
        return UIColor.init(named: "flGrayBlue") ?? UIColor.flDefault
    }
}
