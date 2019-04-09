//
//  AppDelegate.swift
//  TVOSTestApp
//
//  Created by Elias Paulino on 07/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var gamesNavigator = GamesNavigator.init()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        window?.makeKeyAndVisible()
        
        gamesNavigator.show(controllerType: .paperPlate)
        
        return true
    }
}

