//
//  StockInfoVC.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/27/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
import UIKit

class StockInfoVC: UIViewController {
    
    var symbol:String = ""
    var name: String = ""
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      navigationBar.topItem?.title = name
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        performSegueToReturnBack()
    }
}
extension StockInfoVC {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
