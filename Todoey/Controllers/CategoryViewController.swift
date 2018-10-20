//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mohamed EL BATHA on 10/19/18.
//  Copyright © 2018 Mohamed EL BATHA. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK - TableView Datasource Methods ( display all categories )
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
        
    }
    
    //MARK - Data Manipulation Methods ( saveData, loadData to use CRUD )
    func saveCategories() {
        
        do{
            try context.save()
        } catch {
            print("error saving data")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(use request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do{
            categoryArray = try context.fetch(request)
        } catch {
            print("error fetching data")
        }
        tableView.reloadData()
    }
    
    //MARK - Add New Category ( using Category Entity )

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController.init(title: "add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // what will happen once the user clicks the add button on  our UIAlert
            let newcategory = Category(context: self.context)
            newcategory.name = textField.text!
            self.categoryArray.append(newcategory)
            
            self.saveCategories()
            
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
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
}
