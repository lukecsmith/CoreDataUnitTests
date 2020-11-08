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
    let testStack = TestCoreDataStack()
    
    func testCreateAnObject() {
        
        let viewModel = MainViewModel()
        
        //create a brand new test coredatastack, with an in-memory managed object context.
        //do this for every test, to ensure a fresh in-memory store is used for each (no overlap in data)
        let testStack = TestCoreDataStack()
        let context = testStack.mainContext
        viewModel.context = context
        
        do {
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
