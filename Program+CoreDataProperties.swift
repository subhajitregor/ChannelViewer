//
//  Program+CoreDataProperties.swift
//  ChannelViewer
//
//  Created by subhajit halder on 18/05/23.
//
//

import Foundation
import CoreData


extension Program {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Program> {
        return NSFetchRequest<Program>(entityName: "CDProgram")
    }

    @NSManaged public var startTime: String?
    @NSManaged public var id: Int32
    @NSManaged public var length: Int32
    @NSManaged public var name: String?
    @NSManaged public var channel: ChannelItem?

}

extension Program : Identifiable {

}
