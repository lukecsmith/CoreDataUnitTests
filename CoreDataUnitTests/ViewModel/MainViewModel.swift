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
                try fetchObjects()
            } catch {
                throw ViewModelError.errorWhileCreatingObject
            }

        } else {
            throw ViewModelError.missingContext
        }
    }
    
    func fetchObjects() throws {
        do {
            let fetchRequest : NSFetchRequest<ExampleObject> = ExampleObject.fetchRequest()
            guard let context = self.context else {
                throw ViewModelError.missingContext
            }
            self.tableContents = try context.fetch(fetchRequest)
            self.delegate?.refreshTable()
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
        
    }
    
    func removeHighestNumberObject() throws {
        
    }
}
