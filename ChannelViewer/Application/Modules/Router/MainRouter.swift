//
//  MainRouter.swift
//  ChannelViewer
//
//  Created by subhajit halder on 09/05/23.
//

import UIKit

protocol Closable: AnyObject {
    func close()
}

protocol Routable: AnyObject {
    func open(_ viewController: UIViewController, transition: Transition)
}

protocol Router: Routable {
    var rootController: UIViewController? { get set }
    
    var container: DIContainer { get }
}

class MainRouter: Router, Closable {
    
    weak var rootController: UIViewController?
    private var rootTransition: Transition
    
    var container: DIContainer
    
    init(rootTransition: Transition, container: DIContainer) {
        self.rootTransition = rootTransition
        self.container = container
    }

    func open(_ viewController: UIViewController, transition: Transition) {
        guard let rootController = rootController else { return }
        transition.open(viewController, from: rootController)
    }

    func close() {
        guard let root = rootController else { return }
        rootTransition.close(root)
    }
}
