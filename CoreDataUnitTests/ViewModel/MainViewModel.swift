//
//  MainViewModel.swift
//  CoreDataUnitTests
//
//  Created by Luke Smith on 16/10/2017.
//  Copyright © 2017 LukeSmith. All rights reserved.
//

import Foundation
import CoreData

enum CreateObjectError: Error {
    case missingContext
    case unknownError
}

class MainViewModel {
    
    //directly injected from AppDelegate on startup.
    var context : NSManagedObjectContext? = nil
    
    func createAnObject() throws {
        if let context = self.context {
            let newObject = ExampleObject(context: context)
            newObject.randomInt =  Int16(arc4random_uniform(100))
            newObject.date = Date()
        } else {
            throw CreateObjectError.missingContext
        }
    }
    
    func removeMostRecentObject() throws {
        
    }
    
    func removeHighestNumberObject() throws {
        
    }
}
