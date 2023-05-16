//
//  ChannelItem.swift
//  ChannelViewer
//
//  Created by subhajit halder on 14/05/23.
//

import Foundation

struct ChannelItem {
    let orderNum: Int?
    let accessNum: Int?
    let callSign: String?
    let _id: Int?
    var programs: [Program]
    
    mutating func append(programs: [Program]) {
        self.programs.append(contentsOf: programs)
    }
}

struct Program {
    let startTime: String?
    let _id: Int?
    let length: Int?
    let name: String?
}
