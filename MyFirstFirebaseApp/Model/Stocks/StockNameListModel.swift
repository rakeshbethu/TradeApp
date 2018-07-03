//
//  StockNameListModel.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/24/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
class StockNameListModel: NSObject {
    //properties
    
    
    var symbol : String?
    var name : String?
    var date : String?
    var isEnabled : Bool?
    var type : String?
    var iexId : String?
    
    override init() {
        
    }
    
    
    init(symbol : String, name : String, date : String,
    isEnabled : Bool, type : String, iexId : String) {
        self.symbol = symbol
        self.name = name
        self.date = date
        self.isEnabled = isEnabled
        self.type = type
        self.iexId = iexId
    }
    
    
    //prints object's current state
    override var description: String {
        return "Symbol: \(String(describing: symbol)), Name: \(String(describing: name))"
        //     return "Crypto ID: \(id as! String)) "
    }
}

