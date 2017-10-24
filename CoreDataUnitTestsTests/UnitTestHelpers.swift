//
//  UnitTestHelpers.swift
//  CoreDataUnitTests
//
//  Created by Luke Smith on 24/10/2017.
//  Copyright © 2017 LukeSmith. All rights reserved.
//

import Foundation
import CoreData

@testable import CoreDataUnitTests

enum CoreDataError: Error {
    case missingContext
    case errorWhileDeleting
    case couldNotCreateFetchRequest
}

class UnitTestHelpers {
    
    class func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            fatalError("Adding in-memory persistent store failed")
        }
        
        let context = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        
        /* create a dummy object, then delete it.  this avoids fetch request errors later */
        let testObject = ExampleObject(context: context)
        context.delete(testObject)
        
        return context
    }
    
    class func deleteAllObjects<T: NSManagedObject>(objectType: T.Type, withContext moc: NSManagedObjectContext) throws {
        let fetchRequestOp: NSFetchRequest<T>? = T.fetchRequest() as? NSFetchRequest<T>
        guard let fetchRequest = fetchRequestOp else {
            throw CoreDataError.couldNotCreateFetchRequest
        }
        do {
            var results = try moc.fetch(fetchRequest)
            print("Found \(results.count) objects of type \(T.description())")
            results.forEach { object in
                moc.delete(object)
            }
            try moc.save()
            results = try moc.fetch(fetchRequest)
            print("Objects left : \(results.count)")
        } catch {
            throw CoreDataError.couldNotCreateFetchRequest
        }
    }
}
