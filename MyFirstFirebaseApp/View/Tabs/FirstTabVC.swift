//
//  FirstTabVC.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/20/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import FirebaseFirestore

class FirstTabVC: UIViewController,UITableViewDataSource,UISearchBarDelegate,
UITableViewDelegate,allCryptosServiceProtocol, StockNameListServiceProtocol {
    
    
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var segmentedSelector: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var db: Firestore!
    var refresher = UIRefreshControl()
    var isSearching = false
    var selectedSegment = 0
    var CurrencySign = "$"
    //For Cryptos
    var allCryptosArray:NSArray = NSArray()
    var filteredData:NSMutableArray = NSMutableArray()
    var allCryptosNames = [String]()
    
    //Stocks
    var StockNameListArray:NSArray = NSArray()
    var selectedStockSymbol = ""
    var selectedStockName = ""
   
    //Fiat
    var CurrencyList = [[String:Any]]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(FirstTabVC.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.cyan
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        self.searchBar.layer.borderColor = view.backgroundColor?.cgColor
        self.searchBar.layer.borderWidth = 1;
        
        //Refresh Control
        self.tableView.addSubview(self.refreshControl)
        //Crypto Data
        if segmentedSelector.selectedSegmentIndex == 2{
            CryptosDataDownload()
        }else if segmentedSelector.selectedSegmentIndex == 3{
            StockNameListDataDownload()
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        CryptosDataDownload()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        
        if segmentedSelector.selectedSegmentIndex == 1{
            CurrencyDataDownload()
        } else if segmentedSelector.selectedSegmentIndex == 2{
            CryptosDataDownload()
        } else if segmentedSelector.selectedSegmentIndex == 3{
            StockNameListDataDownload()
        }
        
        tableView.reloadData()
    }
    
    //FIAT PART
    func CurrencyDataDownload(){
        db.collection("Currency").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.CurrencyList.removeAll()
                for document in querySnapshot!.documents {
                    
                    // print(document.data())
                    self.CurrencyList.append(document.data())
                    //   print("Count: \(self.CurrencyList.count)")
                }
            }
        }
        tableView.reloadData()
    }
    
    // Crypto Part
    func CryptosDataDownload(){
        let allCryptosServiceInstance = allCryptosService()
        allCryptosServiceInstance.delegate = self as allCryptosServiceProtocol
        allCryptosServiceInstance.downloadItems(urlPath: "https://api.coinmarketcap.com/v1/ticker/?limit=0")
    }
    
    func allCryptosItemsDownloaded(items: NSArray) {
        allCryptosArray = items
        tableView.reloadData()
        for each in items{
            let eachItem = each as! allCryptosModel
            allCryptosNames.append((eachItem.name?.lowercased())!)
            allCryptosNames.append((eachItem.symbol?.lowercased())!)
        }
    }
    
    //StockList
    @IBOutlet weak var StockCountLBL: UILabel!
    func StockNameListDataDownload(){
        let StockNameListInstance = StockNameListService()
        StockNameListInstance.delegate = self as StockNameListServiceProtocol
        StockNameListInstance.downloadItems(urlPath: "https://api.iextrading.com/1.0/ref-data/symbols")
    }
    
    func StockNameListItemsDownloaded(items: NSArray) {
        // print("Items Count \(items.count)")
        StockNameListArray = items
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //   Return the number of feed items
        if segmentedSelector.selectedSegmentIndex == 1{
            //            if isSearching{
            //                return filteredData.count
            //            }
            return  CurrencyList.count
        }else
            if segmentedSelector.selectedSegmentIndex == 2{
                if isSearching{
                    return filteredData.count
                }
                return  allCryptosArray.count
            }else if segmentedSelector.selectedSegmentIndex == 3{
                print("Array Count \(StockNameListArray.count)")
                return  StockNameListArray.count
            }
            else{
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! HomeTableViewCell
        if segmentedSelector.selectedSegmentIndex == 1{
            cell.name.text = "\(CurrencyList[indexPath.row]["Symbol"] as! String)" //CurrencyList[indexPath.row]["Symbol"]
            cell.MarketCap.text = "\(CurrencyList[indexPath.row]["Name"] as! String)" //"\(item.name as! String)"
            //   let usdPrice = StockPrice[item.symbol!]
            cell.USDPrice.text = "\(CurrencySign)\(CurrencyList[indexPath.row]["Price"]!)"
            
            cell.changePercent.isHidden = true
            cell.num.isHidden = true
        }
        else
            if segmentedSelector.selectedSegmentIndex == 2{
                var item = allCryptosModel()
                if isSearching{
                    item = filteredData[indexPath.row] as! allCryptosModel
                }else{
                    item = allCryptosArray[indexPath.row] as! allCryptosModel
                }
                cell.USDPrice.isHidden = false
                cell.changePercent.isHidden = false
                cell.num.isHidden = false
                cell.num.text =   "\(item.rank as! String)"
                cell.name.text = item.name
                cell.MarketCap.text = MarketCapCalculator(marketCapString: item.market_cap_usd!)
                var usdPrice =   (item.price_usd! as NSString).doubleValue
                cell.USDPrice.text = "\(CurrencySign)\(String(format: "%.6g", usdPrice))"
                var percentChange = (item.percent_change_1h as! NSString).doubleValue
                cell.changePercent.text = String(format: "%.2g", percentChange)
                cell.changePercent.textColor = percentChange<0 ? UIColor.red : UIColor.green
                return cell
            }//Stock Table View
            else if segmentedSelector.selectedSegmentIndex == 3{
                var item = StockNameListModel()
                item =  StockNameListArray[indexPath.row] as! StockNameListModel
                cell.name.text = item.symbol
                cell.MarketCap.text =  "\(item.name as! String)"
                //   let usdPrice = StockPrice[item.symbol!]
                cell.USDPrice.isHidden = true
                cell.changePercent.isHidden = true
                cell.num.isHidden = true
            }
            else{
                return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Set selected location to var
        
        if segmentedSelector.selectedSegmentIndex == 2{
        let selectedCrypto = allCryptosArray[indexPath.row] as! allCryptosModel
        } else if segmentedSelector.selectedSegmentIndex == 3{
            let selectedStock = StockNameListArray[indexPath.row] as! StockNameListModel
            selectedStockSymbol = selectedStock.symbol!
            selectedStockName = selectedStock.name!
            self.performSegue(withIdentifier: "stockInfoSegue", sender: self)
        }
       // print(selectedCrypto.id)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            filteredData.removeAllObjects()
            tableView.reloadData()
        }else{
            isSearching = true
            
            let filteredNames = allCryptosNames.filter({$0 == searchBar.text?.lowercased()})
            for each in allCryptosArray{
                let eachItem = each as! allCryptosModel
                if (filteredNames.contains((eachItem.name?.lowercased())!) || filteredNames.contains((eachItem.symbol?.lowercased())!))
                    && !filteredData.contains(each){
                    filteredData.add(each)
                }
            }
            tableView.reloadData()
        }
    }
    
    func MarketCapCalculator(marketCapString : String) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        var returnString = ""
        if marketCapString != "-"{
            let marketCapDouble = (marketCapString as NSString).doubleValue
            
            if marketCapDouble < 1000000  {
                let millionValue = marketCapDouble/1000000
                returnString = "\(formatter.string(from: NSNumber(value: millionValue))!)"
            }else if marketCapDouble >= 1000000 && marketCapDouble < 1000000000 {
                let millionValue = marketCapDouble/1000000
                returnString = "\(formatter.string(from: NSNumber(value: millionValue))!) M"
            }else if marketCapDouble >= 1000000000   {
                let  millionValue = marketCapDouble/1000000000
                returnString = "\(formatter.string(from: NSNumber(value: millionValue))!) B"
            }
        }else{
            returnString =  "-"
        }
        return returnString
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "stockInfoSegue"){
            let nextVC = segue.destination as! StockInfoVC
            nextVC.name = selectedStockName
            nextVC.symbol = selectedStockSymbol
        }
    }
}


