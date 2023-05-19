//
//  CDChannelItem+CoreDataClass.swift
//  ChannelViewer
//
//  Created by subhajit halder on 18/05/23.
//
//

import Foundation
import CoreData


public class CDChannelItem: NSManagedObject {}

extension CDChannelItem: ManagedObjectProtocol {
    func toEntity() -> ChannelItem? {
        let programItems = self.programs?.allObjects as? [CDProgram]
        let toPrograms = programItems?.compactMap { Program(from: $0)}
        return ChannelItem(from: self, and: toPrograms ?? [])
    }
    
}

extension ChannelItem: ManagedObjectConvertible {
    func toManagedObject(in context: NSManagedObjectContext) -> CDChannelItem? {
        let channel = CDChannelItem.getOrCreateSingle(with: "\(_id ?? 0)", from: context)
        channel.id = Int32(_id ?? 0)
        channel.accessNum = Int32(accessNum ?? 0)
        channel.callSign = callSign
        channel.orderNum = Int32(orderNum ?? 0)
        channel.createdAt = Date()
        channel.programs = NSSet(array: program)
        return channel
    }
    
}
