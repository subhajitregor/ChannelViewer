//
//  HomeRemoteDataSource.swift
//  ChannelViewer
//
//  Created by subhajit halder on 15/05/23.
//

import Foundation
import PromiseKit
import CVAPIClient

final class HomeRemoteDataSource: HomeDataSource {
    func getAllChannelsAndPrograms() -> Promise<[ChannelItem]> {
        return fetchChannelItems()
    }
    
    func fetchChannelItems() -> Promise<[ChannelItem]> {
        let p1 = getDataFromChannelsAPI()
        let p2 = getDataFromProgramItemsAPI()
        
        return Promise { seal in
            firstly {
                when(fulfilled: p1, p2)
            } .done { channels, items in
                seal.fulfill(self.createChannelItemModel(channels: channels, items: items))
            } .recover { error in
                p1.done { channels in
                    seal.fulfill(self.createChannelItemModel(channels: channels))
                }.catch { error in
                    seal.reject(error)
                }
            }
        }
    }
    
    func getDataFromChannelsAPI() -> Promise<[Channel]> {
        return Promise { seal in
            ChannelsAPI.channelsGet { data, error in
                guard error == nil else {
                    return seal.reject(error ?? APIError.unknown)
                }
                
                guard let data = data else {
                    return seal.reject(APIError.noData)
                }
                
                seal.fulfill(data)
            }
        }
    }
    
    func getDataFromProgramItemsAPI() -> Promise<[ProgramItem]> {
        return Promise { seal in
            ProgramItemsAPI.programItemsGet { data, error in
                guard error == nil else {
                    return seal.reject(error ?? APIError.unknown)
                }
                
                guard let data = data else {
                    return seal.reject(APIError.noData)
                }
                
                seal.fulfill(data)
            }
            
        }
    }
    
    func createChannelItemModel(channels: [Channel], items: [ProgramItem] = []) -> [ChannelItem] {
        var groupedPrograms: [Int: [Program]] = [:]
        
        if !items.isEmpty {
            for program in items {
                let newProgram = Program(startTime: program.startTime,
                                         _id: program.recentAirTime?._id,
                                         length: program.length,
                                         name: program.name)
                
                groupedPrograms[program.recentAirTime?.channelID ?? 0]?.append(newProgram)
            }
        }
        
        return channels.compactMap { ChannelItem(orderNum: $0.orderNum,
                                                 accessNum: $0.accessNum, callSign: $0.callSign,
                                                 _id: $0._id,
                                                 programs: groupedPrograms[$0._id ?? 0] ?? [])}
    }
}
