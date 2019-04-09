//
//  DistancePanGestureRecognizer.swift
//  TVOSBasics
//
//  Created by Paloma Bispo on 09/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import SceneKit

class DistancePanGestureRecognizer: UIPanGestureRecognizer {

    var distance = CGPoint.zero
    var startPanLocation: CGPoint?
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    func getDistance(in view: UIView?) -> CGPoint {
        let currentLocation = self.location(in: view)

        switch self.state {
        case .began:
            startPanLocation = currentLocation
        case .changed:
            guard let startPanLocation = self.startPanLocation else { return CGPoint.zero}
            let dx = currentLocation.x - startPanLocation.x;
            let dy = currentLocation.y - startPanLocation.y;
            self.distance.x = dx
            self.distance.y = dy
            self.startPanLocation = nil
        default: break
        }
        return distance
    }
}
