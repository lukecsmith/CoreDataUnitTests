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
    case errorWhileFetchingData
}

class UnitTestHelpers {
    
    class func deleteAllObjects<T: NSManagedObject>(objectType: T.Type, withContext moc: NSManagedObjectContext) throws {
        guard let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as? NSFetchRequest<T> else {
            throw CoreDataError.couldNotCreateFetchRequest
        }
        do {
            let results = try moc.fetch(fetchRequest)
            print("Found \(results.count) objects of type \(T.description())")
            results.forEach { object in
                moc.delete(object)
            }
            try moc.save()
        } catch {
            throw CoreDataError.couldNotCreateFetchRequest
        }
    }
    
    class func fetchObjects<T: NSManagedObject>(withContext context: NSManagedObjectContext, sortedBy: String?, ascending: Bool?) throws -> [T] {
        guard let fetchRequest = T.fetchRequest() as? NSFetchRequest<T> else {
            throw CoreDataError.couldNotCreateFetchRequest
        }
        if let sortBy = sortedBy, let ascending = ascending {
            let sortDescriptor = NSSortDescriptor(key: sortBy, ascending: ascending)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
        }
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            throw CoreDataError.errorWhileFetchingData
        }
    }
}
