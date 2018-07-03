//
//  CurrencyPriceService.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/27/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
protocol CurrencyPriceServiceProtocol: class {
    func CurrencyPriceItemsDownloaded(items: NSArray)
}


class CurrencyPriceService: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: CurrencyPriceServiceProtocol!
    
    var data = Data()
    
    func downloadItems(urlPath: String) {
        
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
        let CurrencyPrice = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            let CurrencyPriceObject = CurrencyPriceModel()
            //the following insures none of the JsonElement values are nil through optional binding
            if  let result = jsonElement["result"] as? String,
                let from = jsonElement["from"] as? String{
                
                CurrencyPriceObject.result = result
                CurrencyPriceObject.from = from
                CurrencyPriceObject.timestamp = (jsonElement["timestamp"] as? Int)!
                CurrencyPriceObject.rates = (jsonElement["rates"] as? [String:Double])!
                
            }
            CurrencyPrice.add(CurrencyPriceObject)
        }
        
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.CurrencyPriceItemsDownloaded(items: CurrencyPrice)
        })
    }
    
}


