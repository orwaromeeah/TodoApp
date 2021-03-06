

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController:SwipTableViewController {
    var categoryArray : Results<Category>?
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {

        
        loadData()
        tableView.reloadData()
        super.viewDidLoad()
        tableView.rowHeight=80

    }
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        var textField=UITextField()
        let alert=UIAlertController(title: "Add Category", message: "Type the name of the category ", preferredStyle:.alert)
        let action=UIAlertAction(title:"add", style: .default) { (action) in
            
            let newCategory=Category()
            newCategory.name=textField.text!
            self.save(category: newCategory)
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
        
    let cell=super.tableView(tableView, cellForRowAt: indexPath)
    
    
    cell.textLabel?.text=categoryArray?[indexPath.row].name ?? "not Categories to show"
        return cell
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return categoryArray?.count ?? 1
    }
    //MARK: - tabelView delegate
    
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ItemListViewController
        if let indexPath=tableView.indexPathForSelectedRow {
            destination.selectedCategory=categoryArray![indexPath.row]
        }
    }

    //MARK:- CoreData
    func save(category :Category){
        
        do{
            try realm.write({
                realm.add(category)
            })
        }catch{
            print(error)
        }
      
    }
    func loadData(){

        do{
            try categoryArray=realm.objects(Category.self)
        }catch{
            print(error)
        }
        
    }
    override func updateDate(at indexPath: IndexPath) {
        if let markedCategory = self.categoryArray?[indexPath.row]{
                          do{
                              try  self.realm.write {
                              self.realm.delete(markedCategory)
                              }
                          }catch{ print(error)}
                      }
        self.loadData()
        
    }


}


    

