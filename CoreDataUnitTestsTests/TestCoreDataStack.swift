//
//  CoreDataTestingHelpers.swift
//
//  Created by Luke Smith on 21/10/2020.
//  Copyright © 2020 Luke Smith. All rights reserved.
//

import CoreData
import Foundation

final class TestCoreDataStack: CoreDataStack {
    override init() {
        super.init()

        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(name: CoreDataStack.modelName,
                                              managedObjectModel: CoreDataStack.model)

        container.persistentStoreDescriptions = [persistentStoreDescription]

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        storeContainer = container
    }
}
