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
    
    func testCreateAnObject() {
        //empty store of objects by deleting all.  then add 3 object to it.
        do {
            try UnitTestHelpers.deleteAllObjects(objectType: ExampleObject.self, withContext: context)
            try viewModel.createAnObject()
            try viewModel.createAnObject()
            try viewModel.createAnObject()
        } catch {
            if let vmerror = error as? ViewModelError {
                print("error : \(vmerror.localizedDescription)")
            }
            XCTFail("Could not create objects")
        }
        //create a fetch request to retrieve all those objects
        let fetchRequest = ExampleObject.fetchRequest() as NSFetchRequest<ExampleObject>
        do {
            let results = try context.fetch(fetchRequest)
            XCTAssert(results.count == 3)
        } catch {
            XCTFail("Unabled to fetch objects")
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
