//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mohamed EL BATHA on 10/19/18.
//  Copyright © 2018 Mohamed EL BATHA. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
    }
    
    //MARK - TableView Datasource Methods ( display all categories )
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // syntax called : Nil Coalescing Operator , if categoryArray not nil return count else return 1
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            cell.backgroundColor = UIColor(hexString: category.color)
        } else {
            cell.textLabel?.text = "No Categories Added yet !!"
        }
        
        return cell
    }
    
    //MARK - Data Manipulation Methods ( saveData, loadData to use CRUD )
    func save(category: Category) {
        
        do{
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving data")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryToDelete = self.categories?[indexPath.row] {
            do{
                try self.realm.write {
                self.realm.delete(categoryToDelete)
                }
            } catch {
                print("error while deleting categorie \(error)")
            }
        }
    }
    
    //MARK - Add New Category ( using Category Entity )

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController.init(title: "add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // what will happen once the user clicks the add button on  our UIAlert
            let newcategory = Category()
            newcategory.name = textField.text!
            newcategory.color = UIColor.randomFlat.hexValue()
            self.save(category: newcategory)
            
        }
        
        alert.addTextField { (AlertTextField) in
            AlertTextField.placeholder = "add new category"
            textField = AlertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoeyViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
}
