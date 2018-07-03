//
//  CurrencyModel.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/26/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
class CurrencyModel: NSObject {
    //properties
    
    
    var country : String?
    var name : String?
    var price : Double?
    var symbol : String?
    
    override init() {
        
    }
    
    
    init(country : String, name : String, price : Double,
         symbol : String) {
        self.country = country
        self.name = name
        self.price = price
        self.symbol = symbol
    }
    
    
    //prints object's current state
    override var description: String {
        return "Symbol: \(String(describing: symbol)), Name: \(String(describing: name))"
        //     return "Crypto ID: \(id as! String)) "
    }
}

