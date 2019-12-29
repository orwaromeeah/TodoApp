//
//  ViewController.swift
//  TodoApp
//
//  Created by Orwa Romeeah on 12/28/19.
//  Copyright © 2019 Orwa Romeeah. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray=["firstItem","secondItem","thirdItem"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
    
    //MARK - TABLEVIEW DATASOURCE METHODS
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "todoViewCell", for: indexPath)
        cell.textLabel?.text=itemArray[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    //MARK - Add New Items
    
    
    @IBAction func AddItemPressed(_ sender: Any) {
        var textField=UITextField()
        let alert=UIAlertController(title: "addItem", message: "Add New Item", preferredStyle: .alert)
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
        
            alertTextField.placeholder="Add New Item"
            textField=alertTextField
            
        }
        present(alert,animated: true,completion: nil)
    }
}

