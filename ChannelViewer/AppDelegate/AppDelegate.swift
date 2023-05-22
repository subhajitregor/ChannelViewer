//
//  AppDelegate.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    private let dependencyContainer = DIContainer.shared.container

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainRouter = MainRouter(rootTransition: EmptyTransition(), container: dependencyContainer)
        window?.rootViewController = mainRouter.openHome()
        window?.makeKeyAndVisible()
        return true
    }
}

