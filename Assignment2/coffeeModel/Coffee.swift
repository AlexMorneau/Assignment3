//
//  Coffee.swift
//  Assignment2
//
//  Created by user191445 on 2/18/21.
//

import Foundation


struct Coffee {
    var coffee_type : String
    var coffee_size : String
    var coffee_num : String
    
    
    init() {
        self.coffee_type = ""
        self.coffee_size = ""
        self.coffee_num = ""
    }
    
    init(type : String, size : String, num : String) {
        self.coffee_type = type
        self.coffee_size = size
        self.coffee_num = num
    }
}
