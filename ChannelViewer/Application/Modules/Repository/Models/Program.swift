//
//  Program.swift
//  ChannelViewer
//
//  Created by subhajit halder on 18/05/23.
//

import Foundation

struct Program {
    let startTime: String?
    let length: Int?
    let name: String?
    let _id: Int?
    let channelID: Int?
}

extension Program {
    init(from cdProgram: CDProgram) {
        self.startTime = cdProgram.startTime
        self.length = Int(cdProgram.length)
        self.name = cdProgram.name
        self._id = Int(cdProgram.id)
        self.channelID = Int(cdProgram.channel?.id ?? 0)
    }
}
