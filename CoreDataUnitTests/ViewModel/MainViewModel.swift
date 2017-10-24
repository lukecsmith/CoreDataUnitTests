//
//  MainViewModel.swift
//  CoreDataUnitTests
//
//  Created by Luke Smith on 16/10/2017.
//  Copyright © 2017 LukeSmith. All rights reserved.
//

import Foundation
import CoreData

enum ViewModelError: Error {
    case missingContext
    case noDataForThatRow
    case errorWhileFetchingData
    case errorWhileCreatingObject
    case errorWhileRemovingLastObject
    case errorWhileRemovingHighestNo
    case unableToCreateFetchRequest
}

protocol MainViewModelDelegate {
    func refreshTable()
}

class MainViewModel {
    
    //directly injected from AppDelegate on startup.
    var context : NSManagedObjectContext? = nil
    var tableContents : [ExampleObject] = []
    var delegate : MainViewModelDelegate? = nil
    
    func createAnObject() throws {
        if let context = self.context {
            let newObject = ExampleObject(context: context)
            newObject.randomInt =  Int16(arc4random_uniform(100))
            newObject.date = Date()
            do {
                try context.save()
            } catch {
                throw ViewModelError.errorWhileCreatingObject
            }
        } else {
            throw ViewModelError.missingContext
        }
    }
    
    func updateTableData() {
        do {
            let objects : [ExampleObject] = try self.fetchObjects(sortedBy: nil, ascending: nil)
            self.tableContents = objects
            self.delegate?.refreshTable()
        } catch {
            fatalError("unable to retrieve objects from core data")
        }
    }
    
    func fetchObjects<T: NSManagedObject>(sortedBy: String?, ascending: Bool?) throws -> [T] {
        guard let context = self.context else {
            throw ViewModelError.missingContext
        }
        guard let fetchRequest = T.fetchRequest() as? NSFetchRequest<T> else {
            throw ViewModelError.unableToCreateFetchRequest
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
            throw ViewModelError.errorWhileFetchingData
        }
    }
    
    func getObject(for row : Int) throws -> ExampleObject {
        if tableContents.count > row {
            return tableContents[row]
        } else {
             throw ViewModelError.noDataForThatRow
        }
    }
    
    func removeMostRecentObject() throws {
        guard let context = self.context else {
            throw ViewModelError.missingContext
        }
        do {
            let searchResults : [ExampleObject] = try self.fetchObjects(sortedBy: "date", ascending: true)
            if searchResults.count > 0, let last = searchResults.last {
                context.delete(last)
                self.updateTableData()
            }
        } catch {
            throw ViewModelError.errorWhileRemovingLastObject
        }
    }
    
    func removeHighestNumberObject() throws {
        guard let context = self.context else {
            throw ViewModelError.missingContext
        }
        do {
            let searchResults : [ExampleObject] = try self.fetchObjects(sortedBy: "randomInt", ascending: true)
            if searchResults.count > 0, let last = searchResults.last {
                context.delete(last)
                self.updateTableData()
            }
        } catch {
            throw ViewModelError.errorWhileRemovingHighestNo
        }
    }
}
