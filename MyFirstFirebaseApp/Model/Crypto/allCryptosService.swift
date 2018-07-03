//
//  allCryptosService.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/20/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
protocol allCryptosServiceProtocol: class {
    func allCryptosItemsDownloaded(items: NSArray)
}


class allCryptosService: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: allCryptosServiceProtocol!
    
    var data = Data()
    
    func downloadItems(urlPath: String) {
        print("Okay 3")
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download Cryptos data")
            }else {
                //                print("Data Data downloaded")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    
    //JSON Parser
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            //print(jsonResult)
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let allCryptos = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            let allCryptosObject = allCryptosModel()
            //the following insures none of the JsonElement values are nil through optional binding
            if  let id = jsonElement["id"] as? String,
                let name = jsonElement["name"] as? String,
                let symbol = jsonElement["symbol"] as? String,
                let rank = jsonElement["rank"] as? String
            {
                
                
                allCryptosObject.id = id
                allCryptosObject.name = name
                allCryptosObject.symbol = symbol
                allCryptosObject.rank = rank
                
                allCryptosObject.price_usd = jsonElement["price_usd"] as? String != nil ? jsonElement["price_usd"] as! String : "0"
                allCryptosObject.price_btc = jsonElement["price_btc"] as? String != nil ? jsonElement["price_btc"] as! String : "0"
                allCryptosObject.day_volume_usd = jsonElement["24h_volume_usd"] as? String != nil ? jsonElement["24h_volume_usd"] as! String : "0"
                allCryptosObject.market_cap_usd = jsonElement["market_cap_usd"] as? String != nil ? jsonElement["market_cap_usd"] as! String : "0"
                
                
                allCryptosObject.available_supply = jsonElement["available_supply"] as? String != nil ? jsonElement["available_supply"] as! String : "0"
                allCryptosObject.total_supply = jsonElement["total_supply"] as? String != nil ? jsonElement["total_supply"] as! String : "0"
                allCryptosObject.max_supply = jsonElement["max_supply"] as? String != nil ? jsonElement["max_supply"] as! String : "0"
                allCryptosObject.percent_change_1h = jsonElement["percent_change_1h"] as? String != nil ? jsonElement["percent_change_1h"] as! String : "0"
                allCryptosObject.percent_change_24h = jsonElement["percent_change_24h"] as? String != nil ? jsonElement["percent_change_24h"] as! String : "0"
                allCryptosObject.percent_change_7d = jsonElement["percent_change_7d"] as? String != nil ? jsonElement["percent_change_7d"] as! String : "0"
                allCryptosObject.last_updated = jsonElement["last_updated"] as? String != nil ? jsonElement["last_updated"] as! String : "0"
                
            }
            
            
            
            
            allCryptos.add(allCryptosObject)
            
            
        }
        
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.allCryptosItemsDownloaded(items: allCryptos)
            
            // print(allCryptos)
        })
    }
    
}
