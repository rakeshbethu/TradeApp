//
//  AdminConfigVC.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/26/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AdminConfigVC: UIViewController,CurrencyPriceServiceProtocol {
    var handle: AuthStateDidChangeListenerHandle?
    var db: Firestore!
    
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        print("Hello")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func CurrencyPriceDataDownload(){
        let CurrencyPriceServiceInstance = CurrencyPriceService()
        CurrencyPriceServiceInstance.delegate = self as CurrencyPriceServiceProtocol
        CurrencyPriceServiceInstance.downloadItems(urlPath: "https://v3.exchangerate-api.com/bulk/04f97406ad4d079c90fa0ece/USD")
    }
    
    func CurrencyPriceItemsDownloaded(items: NSArray) {
        
        for each in items{
            let eachItem = each as! CurrencyPriceModel
            db.collection("Currency").document("\(eachItem.from as! String)").setData([
                "Price":eachItem.rates!["\(eachItem.from as! String)"]])
            
        }
    }
    
    var currencyArray  = [String:String]()
    @IBAction func CurrencyPriceAction(_ sender: UIButton) {
        
        //CurrencyPriceDataDownload()
//        db.collection("Currency").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//
//                print(document.data())
//
//                }
//            }
//        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
