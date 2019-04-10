//
//  AppDelegate.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var gamesNavigator = GamesNavigator.init()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        window?.makeKeyAndVisible()
        
        window?.rootViewController = ChooseViewController()
        //gamesNavigator.show(controllerType: .howAmI)
        
        return true
    }
}

