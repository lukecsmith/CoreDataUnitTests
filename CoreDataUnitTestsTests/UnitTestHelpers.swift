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
}
