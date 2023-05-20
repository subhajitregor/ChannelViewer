//
//  HomeLocalDataSource.swift
//  ChannelViewer
//
//  Created by subhajit halder on 15/05/23.
//

import Foundation
import PromiseKit

protocol HomeLocalDataSourceProtocol {
    func insertIntoLocalData(from channelItems: [ChannelItem]) -> Promise<Bool>
    func fetchFromLocalData() -> Promise<[ChannelItem]>
}

final class HomeLocalDataSource: HomeLocalDataSourceProtocol {
    let worker: CoreDataWorkerProtocol?
    
    init(worker: CoreDataWorkerProtocol?) {
        self.worker = worker
    }
    
    func insertIntoLocalData(from channelItems: [ChannelItem]) -> Promise<Bool> {
        guard let worker = worker else { return .value(false) }
        return worker.updateOrInsert(entities: channelItems)
    }
    
    func fetchFromLocalData() -> PromiseKit.Promise<[ChannelItem]> {
        guard let worker = worker else { return .value([]) }
        return worker.get()
    }
}
