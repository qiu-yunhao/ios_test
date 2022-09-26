//
//  AppDelegate.swift
//  Day5
//
//  Created by hello on 2022/9/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var windows: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        windows = UIWindow(frame: UIScreen.main.bounds)
        windows?.rootViewController = ViewController()
        windows?.makeKeyAndVisible()
        windows?.backgroundColor = .white
        return true
    }



}

