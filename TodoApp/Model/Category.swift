//
//  Category.swift
//  TodoApp
//
//  Created by Orwa Romeeah on 1/5/20.
//  Copyright © 2020 Orwa Romeeah. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
   @objc dynamic var name :String=""
    let items=List<Item>()
    
}


