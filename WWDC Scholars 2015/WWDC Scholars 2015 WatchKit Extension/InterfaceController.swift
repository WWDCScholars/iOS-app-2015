//
//  InterfaceController.swift
//  WWDC Scholars 2015 WatchKit Extension
//
//  Created by Matthijs Logemann on 21-05-15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var scholarTable: WKInterfaceTable!
    
    let swiftBlogs = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        loadTableData()

        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadTableData() {
        scholarTable.setNumberOfRows(swiftBlogs.count, withRowType: "scholarCell")
        
        for (index, blogName) in enumerate(swiftBlogs) {
            if let row = scholarTable.rowControllerAtIndex(index) as? ScholarTableRow {
                row.scholarName.setText(blogName)
                row.scholarImage=row.scholarImage.setImageWithUrl("http://ktyreapple.typepad.com/.a/6a0133f1e8b013970b0133f1f3cbda970b-pi")
            }
        }
    }

}
