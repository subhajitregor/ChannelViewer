//
//  ChannelItem+CoreDataProperties.swift
//  ChannelViewer
//
//  Created by subhajit halder on 18/05/23.
//
//

import Foundation
import CoreData


extension ChannelItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChannelItem> {
        return NSFetchRequest<ChannelItem>(entityName: "CDChannelItem")
    }

    @NSManaged public var id: Int32
    @NSManaged public var orderNum: Int32
    @NSManaged public var accessNum: Int32
    @NSManaged public var callSign: String?
    @NSManaged public var programs: NSSet?

}

// MARK: Generated accessors for programs
extension ChannelItem {

    @objc(addProgramsObject:)
    @NSManaged public func addToPrograms(_ value: Program)

    @objc(removeProgramsObject:)
    @NSManaged public func removeFromPrograms(_ value: Program)

    @objc(addPrograms:)
    @NSManaged public func addToPrograms(_ values: NSSet)

    @objc(removePrograms:)
    @NSManaged public func removeFromPrograms(_ values: NSSet)

}

extension ChannelItem : Identifiable {

}
