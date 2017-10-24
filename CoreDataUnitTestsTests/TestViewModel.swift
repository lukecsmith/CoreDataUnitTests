//
//  TestViewModel.swift
//  TestViewModel
//
//  Created by Luke Smith on 14/10/2017.
//  Copyright © 2017 LukeSmith. All rights reserved.
//

import XCTest

@testable import CoreDataUnitTests

class TestViewModel: XCTestCase {
    
    let viewModel = MainViewModel()
    let context = UnitTestHelpers.setUpInMemoryManagedObjectContext()
    
    override func setUp() {
        super.setUp()
        
        //create a view model
        //create a context
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    /*
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
    }*/
    func testCreateAnObject() {
        
    }
    
    func testUpdateTableData() {
    }
    
    func testFetchObjects() {
    }
    
    func testGetObject() {
    }
    
    func testRemoveMostRecentObject() {
    }
    
    func testRemoveHighestNumberObject() {
    }
    
    func switchSortModeAndReturnButtonText() {
    }
    
}
