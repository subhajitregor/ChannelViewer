//
//  Transition.swift
//  ChannelViewer
//
//  Created by subhajit halder on 09/05/23.
//

import UIKit

protocol Transition: AnyObject {
    var isAnimated: Bool { get set }

    func open(_ viewController: UIViewController, from: UIViewController)
    func close(_ viewController: UIViewController)
}
