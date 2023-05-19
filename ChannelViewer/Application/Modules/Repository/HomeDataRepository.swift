//
//  HomeDataRepository.swift
//  ChannelViewer
//
//  Created by subhajit halder on 12/05/23.
//

import Foundation
import PromiseKit

protocol HomeRepository {
    func getAllChannelsAndPrograms() -> Promise<[ChannelItem]>
}

final class HomeDataRepository: HomeRepository {
    
    private let remoteDataSource: HomeRemoteDataSourceProtocol
    private let localDataSource: HomeLocalDataSourceProtocol
    
    init(remoteDataSource: HomeRemoteDataSourceProtocol, localDataSource: HomeLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getAllChannelsAndPrograms() -> Promise<[ChannelItem]> {
        return .value([])
    }
}
