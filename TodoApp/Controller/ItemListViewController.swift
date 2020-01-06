//
//  ViewController.swift
//  TodoApp
//
//  Created by Orwa Romeeah on 12/28/19.
//  Copyright © 2019 Orwa Romeeah. All rights reserved.
//

import UIKit
import RealmSwift

class ItemListViewController: UITableViewController {
    
    let realm=try! Realm()
    var toDoItems : Results<Item>?
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
        return toDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "todoViewCell", for: indexPath)
        if let item=toDoItems?[indexPath.row]{
            cell.textLabel?.text=item.title
            cell.accessoryType=item.done ? .checkmark : .none
            
        }else{
        
        cell.textLabel?.text="not items to show yet"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let currentItem=toDoItems?[indexPath.row] {
            do{ try realm.write {
                currentItem.done = !currentItem.done
                }
                
        }catch{print(error)}
        loadData()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    }
    
    //MARK:- Add New Items
    
    
    @IBAction func AddItemPressed(_ sender: Any) {
        var textField=UITextField()
        
        let alert=UIAlertController(title: "addItem", message: "Add New Item", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                let newItem=Item()
                newItem.title=textField.text!
                newItem.done=false
                newItem.dateCreated = .init()
                do {
                    try    self.realm.write {
                    currentCategory.items.append(newItem)
                }

                }catch{
                    print(error)
                }}
            self.loadData()
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
        
            alertTextField.placeholder="Add New Item"
            textField=alertTextField
            
        }
            self.present(alert,animated: true,completion: nil)
    }
         
    
    //MARK:- Loading data
    func loadData() {
//
            toDoItems=selectedCategory?.items.sorted(byKeyPath:"title")
        
    }
}
   //MARK:- Deleting
 
    

//MARK:- SearchBar extention
  extension ItemListViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
   
        toDoItems=toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated",ascending: false)
        
        
        tableView.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
//            self.loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            tableView.reloadData()
        }
    }
    }
  
