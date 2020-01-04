//
//  ViewController.swift
//  TodoApp
//
//  Created by Orwa Romeeah on 12/28/19.
//  Copyright © 2019 Orwa Romeeah. All rights reserved.
//

import UIKit
import CoreData

class ItemListViewController: UITableViewController {

    var itemArray = [Item]()
    var selectedCategory : Category?{
        didSet{
            loadData()
        }
    }
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
   
    
//MARK: - TABLEVIEW DATASOURCE METHODS
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "todoViewCell", for: indexPath)
        cell.textLabel?.text=itemArray[indexPath.row].title
        if itemArray[indexPath.row].done {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items
    
    
    @IBAction func AddItemPressed(_ sender: Any) {
        var textField=UITextField()
        
        let alert=UIAlertController(title: "addItem", message: "Add New Item", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem=Item(context: self.contex)
            newItem.title=textField.text!
            newItem.done=false
            newItem.parentCategory = self.selectedCategory
            self.saveItems()
            self.loadData()
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
        
            alertTextField.placeholder="Add New Item"
            textField=alertTextField
            
        }
        present(alert,animated: true,completion: nil)
    }
    // MARK:- CoreData adding data
    
    func saveItems(){
        
        do {
            try contex.save()
        }catch{
            print("error saving item")
        }
        
        
    }
    //MARK:- Loading data
    func loadData(with request:NSFetchRequest<Item>=Item.fetchRequest(),predicat:NSPredicate? = nil) {
        let categoryPridecate = NSPredicate(format:"parentCategory == %@", selectedCategory!)
        if let additionalPredicate=predicat{
            request.predicate=NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPredicate,categoryPridecate])
        }else {
            request.predicate=categoryPridecate
        }
        do{
            itemArray=try contex.fetch(request)
        }catch{
            print(error)
        }
    }
   //MARK:- Deleting
 
    
}
//MARK:- SearchBar extention
  extension ItemListViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item>=Item.fetchRequest()
        let predicate = NSPredicate(format:"title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors=[NSSortDescriptor(key:"title", ascending: true)]
        
        loadData(with: request,predicat: predicate)
        tableView.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            self.loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            tableView.reloadData()
        }
    }
    }
  
