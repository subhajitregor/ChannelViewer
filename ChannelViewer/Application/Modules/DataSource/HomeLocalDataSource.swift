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
    func fetchLocalData(from offset: Int, limit: Int) -> Promise<[ChannelItem]>
}

final class HomeLocalDataSource: HomeLocalDataSourceProtocol {
    let worker: CoreDataWorkerProtocol?
    
    init(worker: CoreDataWorkerProtocol?) {
        self.worker = worker
    }
    
    func insertIntoLocalData(from channelItems: [ChannelItem]) -> Promise<Bool> {
        guard let worker = worker else { return .value(false) }
        return worker.deleteAll(ChannelItem.self)
            .then { _ in
                worker.updateOrInsert(entities: channelItems)
            }
    }
    
    func fetchLocalData(from offset: Int, limit: Int) -> Promise<[ChannelItem]> {
        guard let worker = worker else { return .value([]) }
        let sortDescriptor = NSSortDescriptor(key: "orderNum", ascending: true)
        return worker.get(sortDescriptors: [sortDescriptor], fetchOffset: offset, fetchLimit: limit)
    }
}
