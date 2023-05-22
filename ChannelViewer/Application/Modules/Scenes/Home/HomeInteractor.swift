//
//  HomeInteractor.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/04/23.
//

import Foundation

protocol HomePresenterToInteractorProtocol {
    func fetchChannelsAndPrograms()
}

final class HomeInteractor {
    weak var presenter: HomeInteractorToPresenterProtocol?
    var repository: HomeRepository?
}

extension HomeInteractor: HomePresenterToInteractorProtocol {
    func fetchChannelsAndPrograms() {
        repository?.getAllChannelsAndPrograms()
            .done { [weak self] channelItems in
                self?.presenter?.onSuccess(channelsAndPrograms: channelItems)
            } .catch { error in
                self.presenter?.onFailure(error: error)
            }
    }
}
