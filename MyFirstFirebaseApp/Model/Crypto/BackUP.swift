////
////  BackUP.swift
////  MyFirstFirebaseApp
////
////  Created by Rakesh Bethu on 4/21/18.
////  Copyright © 2018 Rakesh Bethu. All rights reserved.
////
//
//import Foundation
//protocol allCryptosServiceProtocol: class {
//    func allCryptosItemsDownloaded(items: NSArray)
//}
//
//
//class allCryptosService: NSObject, URLSessionDataDelegate {
//
//    //properties
//
//    weak var delegate: allCryptosServiceProtocol!
//
//    var data = Data()
//
//    func downloadItems(urlPath: String) {
//        print("Okay 3")
//        let url: URL = URL(string: urlPath)!
//        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
//
//        let task = defaultSession.dataTask(with: url) { (data, response, error) in
//
//            if error != nil {
//                print("Failed to download Cryptos data")
//            }else {
//                //                print("Data Data downloaded")
//                self.parseJSON(data!)
//            }
//        }
//        task.resume()
//    }
//
//
//    //JSON Parser
//    func parseJSON(_ data:Data) {
//
//        var jsonResult = NSArray()
//
//        do{
//            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
//            //print(jsonResult)
//        } catch let error as NSError {
//            print(error)
//
//        }
//
//        var jsonElement = NSDictionary()
//        let allCryptos = NSMutableArray()
//
//        for i in 0 ..< jsonResult.count
//        {
//
//            jsonElement = jsonResult[i] as! NSDictionary
//
//            let allCryptosObject = allCryptosModel()
//            //the following insures none of the JsonElement values are nil through optional binding
//            if  let id = jsonElement["id"] as? String
//                //                let name = jsonElement["name"] as? String,
//                //            let symbol = jsonElement["symbol"] as? String,
//                //            let rank = jsonElement["rank"] as? String,
//                //            let price_usd = jsonElement["price_usd"] as? String,
//                //            let price_btc = jsonElement["price_btc"] as? String,
//                //            let day_volume_usd = jsonElement["24h_volume_usd"] as? String,
//                //            let market_cap_usd = jsonElement["market_cap_usd"] as? String,
//                //            let available_supply = jsonElement["available_supply"] as? String,
//                //            let total_supply = jsonElement["total_supply"] as? String,
//                //            let max_supply = jsonElement["max_supply"] as? String,
//                //            let percent_change_1h = jsonElement["percent_change_1h"] as? String,
//                //            let percent_change_24h = jsonElement["percent_change_24h"] as? String,
//                //            let percent_change_7d = jsonElement["percent_change_7d"] as? String,
//                //            let last_updated = jsonElement["last_updated"] as? String
//
//            {
//
//                //                let name = jsonElement["name"] as? String
//                //                let symbol = jsonElement["symbol"] as? String
//                //                let rank = jsonElement["rank"] as? String
//                //                let price_usd = jsonElement["price_usd"] as? String
//                //                let price_btc = jsonElement["price_btc"] as? String
//                //                let day_volume_usd = jsonElement["24h_volume_usd"] as? String
//                //                let market_cap_usd = jsonElement["market_cap_usd"] as? String
//                //                let available_supply = jsonElement["available_supply"] as? String
//                //                let total_supply = jsonElement["total_supply"] as? String
//                //                let max_supply = jsonElement["max_supply"] as? String
//                //                let percent_change_1h = jsonElement["percent_change_1h"] as? String
//                //                let percent_change_24h = jsonElement["percent_change_24h"] as? String
//                //                let percent_change_7d = jsonElement["percent_change_7d"] as? String
//                //                let last_updated = jsonElement["last_updated"] as? String
//
//
//                allCryptosObject.id = id as String
//                //                allCryptosObject.name = name
//                //                allCryptosObject.symbol = symbol
//                //                allCryptosObject.rank = rank
//                //                allCryptosObject.price_usd = price_usd
//                //                allCryptosObject.price_btc = price_btc
//                //                allCryptosObject.day_volume_usd = day_volume_usd
//                //                allCryptosObject.market_cap_usd = market_cap_usd
//                //                allCryptosObject.available_supply = available_supply
//                //                allCryptosObject.total_supply = total_supply
//                //                allCryptosObject.max_supply = max_supply
//                //                allCryptosObject.percent_change_1h = percent_change_1h
//                //                allCryptosObject.percent_change_24h = percent_change_24h
//                //                allCryptosObject.percent_change_7d = percent_change_7d
//                //                allCryptosObject.last_updated = last_updated
//
//            }
//
//            allCryptos.add(allCryptosObject)
//
//
//        }
//
//
//        DispatchQueue.main.async(execute: { () -> Void in
//            self.delegate.allCryptosItemsDownloaded(items: allCryptos)
//
//        })
//    }
//
//}
//
//
//
//
//
//
//
//
//
////////////
//
//import Foundation
//class allCryptosModel: NSObject {
//    //properties
//
//
//    var id : String?
//    //    var name : String?
//    //    var symbol : String?
//    //    var rank : String?
//    //    var price_usd : String?
//    //    var price_btc : String?
//    //    var day_volume_usd : String?
//    //    var market_cap_usd : String?
//    //    var available_supply : String?
//    //    var total_supply : String?
//    //    var max_supply : String?
//    //    var percent_change_1h : String?
//    //    var percent_change_24h : String?
//    //    var percent_change_7d : String?
//    //    var last_updated : String?
//
//
//    override init() {
//
//    }
//
//    init(id : String
//        //        , name : String, symbol : String, rank : String, price_usd : String, price_btc : String, day_volume_usd : String, market_cap_usd : String, available_supply : String, total_supply : String, max_supply : String, percent_change_1h : String, percent_change_24h : String, percent_change_7d : String, last_updated : String?
//        ) {
//        self.id = id
//        //        self.name = name
//        //        self.symbol = symbol
//        //        self.rank = rank
//        //        self.price_usd = price_usd
//        //        self.price_btc = price_btc
//        //        self.day_volume_usd = day_volume_usd
//        //        self.market_cap_usd = market_cap_usd
//        //        self.available_supply = available_supply
//        //        self.total_supply = total_supply
//        //        self.max_supply = max_supply
//        //        self.percent_change_1h = percent_change_1h
//        //        self.percent_change_24h = percent_change_24h
//        //        self.percent_change_7d = percent_change_7d
//        //        self.last_updated = last_updated
//
//    }
//
//
//    //prints object's current state
//    override var description: String {
//        //        return "Crypto ID: \(String(describing: id)), Name: \(String(describing: name)), USD Price: \(String(describing: price_usd)) "
//        return "Crypto ID: \(id as! String)) "
//    }
//}
