//
//  CoreDataService.swift
//  ChannelViewer
//
//  Created by subhajit halder on 17/05/23.
//

import Foundation
import CoreData
import PromiseKit

protocol CoreDataServiceProtocol {
    var errorHandler: (Error) -> Void {get set}
    var viewContext: NSManagedObjectContext {get}
    var backgroundContext: NSManagedObjectContext {get}
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void)
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void)
}

final class CoreDataService: CoreDataServiceProtocol {
    
    static let shared = CoreDataService()
    var errorHandler: (Error) -> Void = {_ in }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Channel_Viewer")
        container.loadPersistentStores { [weak self] storeDescription, error in
            if let error = error {
                NSLog("CoreData error \(error), \(String(describing: error._userInfo))")
                self?.errorHandler(error)
            }
        }
        return container
    }()
    
    //Core Data Saving support
    func save () {
        let context = viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    lazy var viewContext: NSManagedObjectContext = {
        let context:NSManagedObjectContext = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.perform {
            block(self.viewContext)
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
}
