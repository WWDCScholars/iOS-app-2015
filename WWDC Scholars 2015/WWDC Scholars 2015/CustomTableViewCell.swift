//
//  CustomTableViewCell.swift
//  WWDC Scholars 2015
//
//  Created by Gelei Chen on 15/5/22.
//  Copyright (c) 2015年 WWDC-Scholars. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {



    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var location: UILabel!
    
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
