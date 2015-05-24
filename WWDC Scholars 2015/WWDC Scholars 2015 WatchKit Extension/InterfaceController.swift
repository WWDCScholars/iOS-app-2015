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

    var scholars = NSMutableArray()
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var defaults = NSUserDefaults(suiteName: "group.wwdcscholars.2015")
        
        var allScholarsJson = defaults?.objectForKey("scholars") as! NSArray
        for dict: NSDictionary in allScholarsJson as! [NSDictionary]{
            var scholar = Scholar(name: dict.objectForKey("name") as? String,
                age: dict.objectForKey("age") as! Int,
                latitude: dict.objectForKey("latitude") as! Double,
                longitude: dict.objectForKey("longitude") as! Double,
                picture: dict.objectForKey("picture") as? String,
                shortBio: dict.objectForKey("shortBio") as? String,
                numberOfWWDCAttend: dict.objectForKey("numberOfWWDCAttend") as? Int,
                location: dict.objectForKey("location") as? String)
            scholars.addObject(scholar)
            println(scholar)
        }
        println("Loaded \(allScholarsJson.count) scholars")

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
        scholarTable.setNumberOfRows(scholars.count, withRowType: "scholarCell")
        
        for (index, scholar) in enumerate((scholars as NSArray) as! [Scholar]) {
            if let row = scholarTable.rowControllerAtIndex(index) as? ScholarTableRow {
                row.scholarName.setText(scholar.name)
                if let profilePic = scholar.picture{
                    row.scholarImage=row.scholarImage.setImageWithUrl(profilePic)
                }
            }
        }
    }

}
