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

protocol HomeDataSource {
    func getAllChannelsAndPrograms() -> Promise<[ChannelItem]>
}

final class HomeDataRepository: HomeRepository {
    
    private let remoteDataSource: HomeDataSource
    private let localDataSource: HomeDataSource
    
    init(remoteDataSource: HomeDataSource, localDataSource: HomeDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getAllChannelsAndPrograms() -> Promise<[ChannelItem]> {
        return .value([])
    }
}
