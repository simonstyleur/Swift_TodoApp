//
//  Item.swift
//  Todoey
//
//  Created by Mohamed EL BATHA on 10/20/18.
//  Copyright © 2018 Mohamed EL BATHA. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done : Bool  = false
    @objc dynamic var dateCreated: Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
