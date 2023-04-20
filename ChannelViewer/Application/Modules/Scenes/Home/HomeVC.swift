//
//  HomeVC.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import UIKit

protocol HomeViewToPresenterProtocol {
    func viewDidLoad()
}

final class HomeVC: UIViewController {
    
    var presenter: HomeViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = .cyan
    }
}

extension HomeVC: HomePresenterToViewProtocol {
    
}
