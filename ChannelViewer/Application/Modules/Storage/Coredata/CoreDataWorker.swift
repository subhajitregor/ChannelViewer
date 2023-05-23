//
//  CoreDataWorker.swift
//  ChannelViewer
//
//  Created by subhajit halder on 19/05/23.
//

import Foundation
import PromiseKit
import CoreData

protocol CoreDataWorkerProtocol {
    func get<Entity: ManagedObjectConvertible>(with predicate: NSPredicate?,
                                               sortDescriptors: [NSSortDescriptor]?,
                                               fetchOffset: Int?,
                                               fetchLimit: Int?) -> Promise<[Entity]>
    
    func updateOrInsert<Entity: ManagedObjectConvertible>
    (entities: [Entity]) -> Promise<Bool>
    
    func deleteAll<Entity: ManagedObjectConvertible>(_ entity: Entity.Type) -> Promise<Bool>
}

extension CoreDataWorkerProtocol {
    func get<Entity: ManagedObjectConvertible>(with predicate: NSPredicate? = nil,
                                               sortDescriptors: [NSSortDescriptor]? = nil,
                                               fetchOffset: Int? = nil,
                                               fetchLimit: Int? = nil) -> Promise<[Entity]> {
        get(with: predicate, sortDescriptors: sortDescriptors, fetchOffset: fetchOffset, fetchLimit: fetchLimit)
    }
}

enum CoreDataWorkerError: Error {
    case cannotFetch(String)
    case cannotSave(Error)
    case dataSetEmpty
}

final class CoreDataWorker: CoreDataWorkerProtocol {
    
    let coreData: CoreDataServiceProtocol
    
    init(coreData: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreData = coreData
    }
    
    func get<Entity: ManagedObjectConvertible>(with predicate: NSPredicate? = nil,
                                               sortDescriptors: [NSSortDescriptor]? = nil,
                                               fetchOffset: Int? = nil,
                                               fetchLimit: Int? = nil) -> PromiseKit.Promise<[Entity]> {
        return Promise{ seal in
            coreData.performForegroundTask { context in
                do {
                    let fetchRequest = Entity.ManagedObject.fetchRequest()
                    fetchRequest.predicate = predicate
                    fetchRequest.sortDescriptors = sortDescriptors
                    
                    if let fetchLimit = fetchLimit {
                        fetchRequest.fetchLimit = fetchLimit
                    }
                    if let fetchOffset = fetchOffset {
                        fetchRequest.fetchOffset = fetchOffset
                    }
                    
                    let results = try context.fetch(fetchRequest) as? [Entity.ManagedObject]
                    let items: [Entity] = results?.compactMap { $0.toEntity() as? Entity } ?? []
                    if items.isEmpty {
                        return seal.reject(CoreDataWorkerError.dataSetEmpty)
                    }
                    seal.fulfill(items)
                } catch {
                    let fetchError = CoreDataWorkerError.cannotFetch("Cannot fetch error: \(error))")
                    seal.reject(fetchError)
                }
            }
        }
    }
    
    func updateOrInsert<Entity: ManagedObjectConvertible>(entities: [Entity]) -> PromiseKit.Promise<Bool> {
        return Promise { seal in
            coreData.performBackgroundTask { context in
                _ = entities.compactMap({ (entity) -> Entity.ManagedObject? in
                    return entity.toManagedObject(in: context)
                })
                do {
                    try context.save()
                    seal.fulfill(true)
                } catch {
                    seal.reject(CoreDataWorkerError.cannotSave(error))
                }
            }
        }
    }
    
    func deleteAll<Entity: ManagedObjectConvertible>(_ entity: Entity.Type) -> Promise<Bool> {
        return Promise { seal in
            coreData.performBackgroundTask { context in
                let fetchRequest = Entity.ManagedObject.fetchRequest()
                fetchRequest.returnsObjectsAsFaults = false
                do {
                    let results = try context.fetch(fetchRequest)
                    if !results.isEmpty {
                        for object in results {
                            guard let objectData = object as? NSManagedObject else {continue}
                            context.delete(objectData)
                            seal.fulfill(true)
                        }
                    } else {
                        seal.fulfill(false)
                    }
                } catch let error {
                    print("Detele all data in \(entity) error :", error)
                    seal.reject(error)
                }
            }
            
        }
    }
}
