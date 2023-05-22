//
//  HomePresenter.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import Foundation
import PromiseKit

protocol HomeViewToPresenterProtocol {
    func viewDidLoad()
}

protocol HomeInteractorToPresenterProtocol: AnyObject {
    func onSuccess(channelsAndPrograms: [ChannelItem])
    func onFailure(error: Error)
}

protocol HomePresenterToRouterProtocol {
    
}

final class HomePresenter {
    weak var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
}

extension HomePresenter: HomeViewToPresenterProtocol {
    func viewDidLoad() {
        interactor?.fetchChannelsAndPrograms()
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func onSuccess(channelsAndPrograms: [ChannelItem]) {
        print(channelsAndPrograms)
    }
    
    func onFailure(error: Error) {
        print(error)
    }
}
