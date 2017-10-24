//
//  MainViewController.swift
//  CoreDataUnitTests
//
//  Created by Luke Smith on 14/10/2017.
//  Copyright © 2017 LukeSmith. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainViewModelDelegate {
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortByButton: UIButton!
    let viewModel = MainViewModel()
    //MARK: Object Lifecycle
    override func awakeFromNib() {
        self.viewModel.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toggleSortMode() //also updates the tableview
    }
    //MARK: Tableview DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        do {
            let object = try viewModel.getObject(for: indexPath.row)
            cell.textLabel?.text = "\(String(describing: object.date!))"
            cell.detailTextLabel?.text = "\(object.randomInt)"
        } catch {
            cell.textLabel?.text = "No data"
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableContents.count
    }
    @IBAction func addClicked(_ sender: Any) {
        do {
            try self.viewModel.createAnObject()
        } catch {
            fatalError("Missing core data context")
        }
        self.viewModel.updateTableData()
    }
    //MARK: IBActions
    @IBAction func sortByClicked(_ sender: Any) {
        self.toggleSortMode()
    }
    @IBAction func delHighestClicked(_ sender: Any) {
        do {
            try self.viewModel.removeHighestNumberObject()
        } catch {
            fatalError("Missing core data context")
        }
        self.viewModel.updateTableData()
    }
    @IBAction func delLastClicked(_ sender: Any) {
        do {
            try self.viewModel.removeMostRecentObject()
        } catch {
            fatalError("Missing core data context")
        }
        self.viewModel.updateTableData()
    }
    func toggleSortMode() {
        let text = self.viewModel.switchSortModeAndReturnButtonText()
        self.sortByButton.setTitle(text, for: UIControlState.normal)
        self.viewModel.updateTableData()
    }
    //MARK: MainViewModelDelegate
    func refreshTable() {
        self.tableView.reloadData()
    }
    
}

