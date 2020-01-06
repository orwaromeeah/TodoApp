//
//  SwipTableViewController.swift
//  TodoApp
//
//  Created by Orwa Romeeah on 1/6/20.
//  Copyright © 2020 Orwa Romeeah. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipTableViewController: UITableViewController,SwipeTableViewCellDelegate {
   
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
              guard orientation == .right else { return nil }
              let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                self.updateDate(at: indexPath)
    //          
              }
               deleteAction.image = UIImage(named: "delete-icon")
              return [deleteAction]
          }
    
   
    func updateDate(at indexPath:IndexPath){
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        return cell
    }

    
        
        
      func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
          var options = SwipeOptions()
          options.expansionStyle = .destructive
          return options
      }
   

    
}

