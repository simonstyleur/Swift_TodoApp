//
//  ViewController.swift
//  Todoey
//
//  Created by Mohamed EL BATHA on 10/13/18.
//  Copyright © 2018 Mohamed EL BATHA. All rights reserved.
//

import UIKit

class TodoeyViewController: UITableViewController {

    var itemArray = [Item]()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = Item(newTitle: "item1")
        let item2 = Item(newTitle: "item2")
        let item3 = Item(newTitle: "item3")
        
        itemArray.append(item1)
        itemArray.append(item2)
        itemArray.append(item3)
        
        
        if let items = userDefaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }

    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add new Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController.init(title: "add new todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the add button on  our UIAlert
            let newitem = Item(newTitle: textField.text!)
            self.itemArray.append(newitem)
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

