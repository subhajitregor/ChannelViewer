//
//  CustomManagedObjectProtocols.swift
//  ChannelViewer
//
//  Created by subhajit halder on 19/05/23.
//

import Foundation
import CoreData

protocol ManagedObjectConvertible {
    associatedtype ManagedObject: NSManagedObject, ManagedObjectProtocol
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
}

protocol ManagedObjectProtocol {
    associatedtype Entity
    func toEntity() -> Entity?
}

extension ManagedObjectProtocol where Self: NSManagedObject {
    static func getOrCreateSingle(with id: Int32, from context: NSManagedObjectContext) -> Self {
        let result = single(with: id, from: context) ?? insertNew(in: context)
        result.setValue(id, forKey: "id")
        return result
    }
    
    static func single(from context: NSManagedObjectContext, with predicate: NSPredicate?,
                       sortDescriptors: [NSSortDescriptor]?) -> Self? {
        return fetch(from: context, with: predicate,
                     sortDescriptors: sortDescriptors, fetchLimit: 1)?.first
    }
    
    static func single(with id: Int32, from context: NSManagedObjectContext) -> Self? {
        let predicate = NSPredicate(format: "id == %d", id)
        return single(from: context, with: predicate, sortDescriptors: nil)
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self {
        return Self(context:context)
    }
    
    static func fetch(from context: NSManagedObjectContext, with predicate: NSPredicate?,
                      sortDescriptors: [NSSortDescriptor]?, fetchLimit: Int?) -> [Self]? {
        
        let fetchRequest = Self.fetchRequest()
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        fetchRequest.returnsObjectsAsFaults = false
        
        if let fetchLimit = fetchLimit {
            fetchRequest.fetchLimit = fetchLimit
        }
        
        var result: [Self]?
        context.performAndWait { () -> Void in
            do {
                result = try context.fetch(fetchRequest) as? [Self]
            } catch {
                result = nil
                //Report Error
                print("CoreData fetch error \(error)")
            }
        }
        return result
    }
}
