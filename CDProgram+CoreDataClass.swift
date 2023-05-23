//
//  CDProgram+CoreDataClass.swift
//  ChannelViewer
//
//  Created by subhajit halder on 18/05/23.
//
//

import Foundation
import CoreData


public class CDProgram: NSManagedObject {}

extension CDProgram: ManagedObjectProtocol {
    func toEntity() -> Program? {
        Program(from: self)
    }
}

extension Program: ManagedObjectConvertible {
    func toManagedObject(in context: NSManagedObjectContext) -> CDProgram? {
        let itemId = Int32(_id ?? 0)
        let program = CDProgram.getOrCreateSingle(with: itemId, from: context)
        program.id = itemId
        program.length = Int32(length ?? 0)
        program.name = name
        program.startTime = startTime
        return program
    }
}
