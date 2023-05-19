//
//  CDChannelItem+CoreDataProperties.swift
//  ChannelViewer
//
//  Created by subhajit halder on 18/05/23.
//
//

import Foundation
import CoreData


extension CDChannelItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDChannelItem> {
        return NSFetchRequest<CDChannelItem>(entityName: "ChannelItem")
    }

    @NSManaged public var id: Int32
    @NSManaged public var orderNum: Int32
    @NSManaged public var accessNum: Int32
    @NSManaged public var callSign: String?
    @NSManaged public var programs: NSSet?
    @NSManaged public var createdAt: Date!
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setPrimitiveValue(Date(), forKey: #keyPath(CDChannelItem.createdAt))
    }

}

// MARK: Generated accessors for programs
extension CDChannelItem {

    @objc(addProgramsObject:)
    @NSManaged public func addToPrograms(_ value: CDProgram)

    @objc(removeProgramsObject:)
    @NSManaged public func removeFromPrograms(_ value: CDProgram)

    @objc(addPrograms:)
    @NSManaged public func addToPrograms(_ values: NSSet)

    @objc(removePrograms:)
    @NSManaged public func removeFromPrograms(_ values: NSSet)

}

extension CDChannelItem : Identifiable {}

