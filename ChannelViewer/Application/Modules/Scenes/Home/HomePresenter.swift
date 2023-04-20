//
//  HomePresenter.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import Foundation

protocol HomePresenterToViewProtocol: AnyObject {
    
}

protocol HomePresenterToInteractorProtocol {
    
}

protocol HomePresenterToRouterProtocol {
    
}

final class HomePresenter {
    weak var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
}

extension HomePresenter: HomeViewToPresenterProtocol {
    func viewDidLoad() {}
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    
}
