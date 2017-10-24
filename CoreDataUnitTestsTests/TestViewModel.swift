//
//  TestViewModel.swift
//  TestViewModel
//
//  Created by Luke Smith on 14/10/2017.
//  Copyright © 2017 LukeSmith. All rights reserved.
//

import XCTest
import CoreData

@testable import CoreDataUnitTests

class TestViewModel: XCTestCase {
    
    let viewModel = MainViewModel()
    let context = UnitTestHelpers.setUpInMemoryManagedObjectContext()
    
    override func setUp() {
        super.setUp()
        //put our test context onto the viewmodel
        viewModel.context = self.context
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
        do {
            try UnitTestHelpers.deleteAllObjects(objectType: ExampleObject.self, withContext: context)
            try viewModel.createAnObject()
            try viewModel.createAnObject()
        } catch {
            XCTFail("Could not delete objects")
        }
        guard let fetchRequest = ExampleObject.fetchRequest() as? NSFetchRequest else {
            XCTFail("Unable to create fetch request")
        }
        do {
            let results = try context.fetch(fetchRequest)
            XCTAssert(results.count == 2)
        } catch {
            XCTFail("Cannot fetch results")
        }
        
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
