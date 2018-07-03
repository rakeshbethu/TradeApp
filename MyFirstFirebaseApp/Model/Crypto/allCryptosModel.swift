//
//  allCryptosModel.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/20/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
class allCryptosModel: NSObject {
    //properties
    var id : String?
    var name : String?
    var symbol : String?
    var rank : String?
    var price_usd : String?
    var price_btc : String?
    var day_volume_usd : String?
    var market_cap_usd : String?
    var available_supply : String?
    var total_supply : String?
    var max_supply : String?
    var percent_change_1h : String?
    var percent_change_24h : String?
    var percent_change_7d : String?
    var last_updated : String?
    
    override init() {
    }
    
    init(id : String, name : String, symbol : String, rank : String, price_usd : String, price_btc : String, day_volume_usd : String, market_cap_usd : String, available_supply : String, total_supply : String, max_supply : String, percent_change_1h : String, percent_change_24h : String, percent_change_7d : String, last_updated : String?
        ) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.rank = rank
        self.price_usd = price_usd
        self.price_btc = price_btc
        self.day_volume_usd = day_volume_usd
        self.market_cap_usd = market_cap_usd
        self.available_supply = available_supply
        self.total_supply = total_supply
        self.max_supply = max_supply
        self.percent_change_1h = percent_change_1h
        self.percent_change_24h = percent_change_24h
        self.percent_change_7d = percent_change_7d
        self.last_updated = last_updated
        }
    //prints object's current state
    override var description: String {
        return "Crypto ID: \(String(describing: id)), Name: \(String(describing: name)), USD Price: \(String(describing: price_usd)) "
    }
}
