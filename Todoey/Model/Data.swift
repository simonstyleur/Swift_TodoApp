//
//  Data.swift
//  Todoey
//
//  Created by Mohamed EL BATHA on 10/20/18.
//  Copyright © 2018 Mohamed EL BATHA. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
