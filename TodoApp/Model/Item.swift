//
//  Item.swift
//  TodoApp
//
//  Created by Orwa Romeeah on 1/5/20.
//  Copyright © 2020 Orwa Romeeah. All rights reserved.
//

import Foundation
import RealmSwift
class Item : Object {
    @objc dynamic var title:String=""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated = NSDate()
    var category=LinkingObjects(fromType: Category.self, property:"items")
}
