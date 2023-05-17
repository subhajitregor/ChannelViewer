//
//  EmptyTransition.swift
//  ChannelViewer
//
//  Created by subhajit halder on 12/05/23.
//

import UIKit

final class EmptyTransition {
    var isAnimated: Bool = true
}

extension EmptyTransition: Transition {
    func open(_ viewController: UIViewController, from: UIViewController) {}
    
    func close(_ viewController: UIViewController) {}
}

