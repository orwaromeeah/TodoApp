//
//  CategoryViewController.swift
//  TodoApp
//
//  Created by Orwa Romeeah on 12/31/19.
//  Copyright © 2019 Orwa Romeeah. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    var categoryArray=[Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    override func viewDidLoad() {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadData()
        tableView.reloadData()
        super.viewDidLoad()
 

    }
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add Category", message: "Type the name of the category ", preferredStyle:.alert)
        let action=UIAlertAction(title:"add", style: .default) { (action) in
            
            let newCategory=Category(context: self.context)
            newCategory.name=textField.text
            self.saveItem()
            self.loadData()
            self.tableView.reloadData()
            
            
            
        }
        alert.addAction(action)
        alert.addTextField { (UITextField) in
            UITextField.placeholder="category..."
            textField=UITextField
        }
    present(alert, animated: true, completion:nil)
        
    }
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "categoryViewCell", for: indexPath)
        cell.textLabel?.text=categoryArray[indexPath.row].name
        return cell
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return categoryArray.count
    }
    //MARK:-tabelView delegate
    
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ItemListViewController
        if let indexPath=tableView.indexPathForSelectedRow {
            destination.selectedCategory=categoryArray[indexPath.row]
        }
    }

    //MARK:- CoreData
    func saveItem(){
        
        do{
            try context.save()
        }catch{
            print(error)
        }
        
    }
    func loadData(){
        let request : NSFetchRequest<Category>=Category.fetchRequest()
        do{
            categoryArray=try context.fetch(request)
        }catch{
            print(error)
        }
        
    }

}
