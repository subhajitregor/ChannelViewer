//
//  HomeRoute.swift
//  ChannelViewer
//
//  Created by subhajit halder on 09/05/23.
//

import UIKit

protocol HomeRoute {
    func openHome() -> UIViewController
}

extension HomeRoute where Self: Router {
    func openHome(with transition: Transition) -> UIViewController {
        let viewController: HomeVC = HomeVC(presenter: container.resolve())
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    func openHome() -> UIViewController {
        openHome(with: EmptyTransition())
    }
}

extension MainRouter: HomeRoute {}
