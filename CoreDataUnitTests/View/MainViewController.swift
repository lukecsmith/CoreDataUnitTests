//
//  MainViewController.swift
//  CoreDataUnitTests
//
//  Created by Luke Smith on 14/10/2017.
//  Copyright © 2017 LukeSmith. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = MainViewModel()
    
    override func awakeFromNib() {
        self.viewModel.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try self.viewModel.fetchObjects()
        } catch {
            fatalError("Unable to fetch objects from core data")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    
    @IBAction func delHighestClicked(_ sender: Any) {
        
    }
    
    @IBAction func delLastClicked(_ sender: Any) {
        
    }
    
    //MARK: MainViewModelDelegate
    
    func refreshTable() {
        self.tableView.reloadData()
    }
    
}

