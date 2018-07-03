//
//  CurrencyPriceModel.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/27/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
class CurrencyPriceModel: NSObject {
    //properties
    
    
    var result : String?
    var timestamp : Int?
    var from : String?
    var rates : [String:Double]?
    
    override init() {
        
    }
    
    
    init(result : String, timestamp : Int, from : String,
          rates : [String:Double]) {
        self.result = result
        self.timestamp = timestamp
        self.from = from
        self.rates = rates
    }
    
    
    //prints object's current state
    override var description: String {
        return "Symbol: \(String(describing: from)), Time: \(String(describing: timestamp))"
        //     return "Crypto ID: \(id as! String)) "
    }
}
