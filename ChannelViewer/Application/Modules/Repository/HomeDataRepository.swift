//
//  HomeDataRepository.swift
//  ChannelViewer
//
//  Created by subhajit halder on 12/05/23.
//

import Foundation
import PromiseKit

protocol HomeRepository {
    func getAllChannelsAndPrograms(from offset: Int, limit: Int) -> Promise<[ChannelItem]>
}

enum HomeRepositoryError: Error {
    case oldDataInLocal
}

final class HomeDataRepository: HomeRepository {
    private enum StaticValues {
        static let maxHoursForDataValidity: Int = 6
    }
    
    private let remoteDataSource: HomeRemoteDataSourceProtocol
    private let localDataSource: HomeLocalDataSourceProtocol
    
    init(remoteDataSource: HomeRemoteDataSourceProtocol, localDataSource: HomeLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getAllChannelsAndPrograms(from offset: Int, limit: Int) -> Promise<[ChannelItem]> {
        return Promise { [weak self] seal in
            guard let self = self else { return }
            
            self.startFetch(from: offset, limit: limit).done({ channelItems in
                seal.fulfill(channelItems)
            }) .recover({  error in
                self.fetchDataFromRemote()
                    .then({ items in
                        self.localDataSource.insertIntoLocalData(from: items)
                    })
                    .then({ _ in
                        self.startFetch(from: offset, limit: limit)
                    })
                    .catch({ error in
                        seal.reject(error)
                    })
            })
        }
    }
}

private extension HomeDataRepository {
    func startFetch(from offset: Int, limit: Int) -> Promise<[ChannelItem]> {
        return Promise { [weak self] seal in
            self?.checkForDataInLocal(from: offset, limit: limit).done { channelItems in
                return seal.fulfill(channelItems)
            } .catch { error in
                seal.reject(error)
            }
        }
    }
    
    func checkForDataInLocal(from offset: Int, limit: Int) -> Promise<[ChannelItem]> {
        return Promise { [weak self] seal in
            self?.localDataSource.fetchLocalData(from: offset, limit: limit)
                .done({ channelItems in
                    if self?.canUseLocalData(date: channelItems.first?.createdAt) ?? false {
                        seal.fulfill(channelItems)
                    } else {
                        seal.reject(HomeRepositoryError.oldDataInLocal)
                    }
                }) .catch { error in
                    seal.reject(error)
                }
        }
    }
    
    func canUseLocalData(date: Date?) -> Bool {
        dataAgeInHrs(from: date) < StaticValues.maxHoursForDataValidity
    }
    
    func dataAgeInHrs(from createdDate: Date?) -> Int {
        guard let timeDifference = createdDate?.timeIntervalSince(Date()) else { return StaticValues.maxHoursForDataValidity }
        return Int(ceil(timeDifference / 60 / 60))
    }
    
    func fetchDataFromRemote() -> Promise<[ChannelItem]> {
        remoteDataSource.getAllChannelsAndPrograms()
    }
}
