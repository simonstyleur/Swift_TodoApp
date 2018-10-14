//
//  ViewController.swift
//  Todoey
//
//  Created by Mohamed EL BATHA on 10/13/18.
//  Copyright © 2018 Mohamed EL BATHA. All rights reserved.
//

import UIKit

class TodoeyViewController: UITableViewController {

    var itemArray = ["Find Make", "Buy Eggos", "Destroy Demogorgoy"]
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = userDefaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController.init(title: "add new todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the add button on  our UIAlert
            self.itemArray.append(textField.text!)
            self.userDefaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()

        }
        
        alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "add new item"
            textField = AlertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

