//
//  Category.swift
//  Todoey
//
//  Created by Mohamed EL BATHA on 10/20/18.
//  Copyright © 2018 Mohamed EL BATHA. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
