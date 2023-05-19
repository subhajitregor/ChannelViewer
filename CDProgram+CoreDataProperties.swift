//
//  CDProgram+CoreDataProperties.swift
//  ChannelViewer
//
//  Created by subhajit halder on 18/05/23.
//
//

import Foundation
import CoreData


extension CDProgram {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProgram> {
        return NSFetchRequest<CDProgram>(entityName: "Program")
    }

    @NSManaged public var startTime: String?
    @NSManaged public var id: Int32
    @NSManaged public var length: Int32
    @NSManaged public var name: String?
    @NSManaged public var channel: CDChannelItem?

}

extension CDProgram : Identifiable {

}
