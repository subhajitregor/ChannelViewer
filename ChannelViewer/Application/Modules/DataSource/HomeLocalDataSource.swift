//
//  HomeLocalDataSource.swift
//  ChannelViewer
//
//  Created by subhajit halder on 15/05/23.
//

import Foundation
import PromiseKit

final class HomeLocalDataSource: HomeDataSource {
    func getAllChannelsAndPrograms() -> Promise<[ChannelItem]> {
        return .value([])
    }
}
