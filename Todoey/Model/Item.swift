//
//  Todo.swift
//  Todoey
//
//  Created by Mohamed EL BATHA on 10/14/18.
//  Copyright © 2018 Mohamed EL BATHA. All rights reserved.
//

class Item {
    
    //TODO: Messages need a messageBody and a sender variable
    
    var title : String = ""
    var done: Bool = false
    
    init(newTitle: String) {
        title = newTitle
    }
}
