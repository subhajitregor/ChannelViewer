//
//  ChannelItem.swift
//  ChannelViewer
//
//  Created by subhajit halder on 18/05/23.
//

import Foundation

struct ChannelItem {
    let orderNum: Int?
    let accessNum: Int?
    let callSign: String?
    let _id: Int?
    let createdAt: Date?
    var program: [Program] = []
}

extension ChannelItem {
    init(from cdChannelItem: CDChannelItem, and programs: [Program]) {
        self.orderNum = Int(cdChannelItem.orderNum)
        self.accessNum = Int(cdChannelItem.accessNum)
        self.callSign = cdChannelItem.callSign
        self._id = Int(cdChannelItem.id)
        self.program = programs
        self.createdAt = cdChannelItem.createdAt
    }
}


