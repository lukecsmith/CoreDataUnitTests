//
//  CoreDataStack.swift
//  PlatformMotif-debug
//
//  Created by Luke Smith on 26/10/2020.
//  Copyright © 2020 uMotif. All rights reserved.
//

import CoreData
import Foundation

open class CoreDataStack {
    public static let modelName = "CoreDataUnitTests"

    public static let model: NSManagedObjectModel = {
        // swiftlint:disable force_unwrapping
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    // swiftlint:enable force_unwrapping

    public init() {}

    public lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()

    public lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    public func newDerivedContext() -> NSManagedObjectContext {
        let context = storeContainer.newBackgroundContext()
        return context
    }
}
