//
//  AppDelegate.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = HomeVC()
        window?.makeKeyAndVisible()
        return true
    }
}

