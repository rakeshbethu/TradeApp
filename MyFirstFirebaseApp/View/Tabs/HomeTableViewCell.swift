//
//  HomeTableViewCell.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/21/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var MarketCap: UILabel!
    @IBOutlet weak var USDPrice: UILabel!
    @IBOutlet weak var changePercent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
