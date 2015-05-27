//
//  StudentsInterfaceController.swift
//  WWDC Scholars 2015
//
//  Created by Matthijs Logemann on 25-05-15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import WatchKit
import Foundation


class StudentsInterfaceController: WKInterfaceController {

    @IBOutlet var scholarTable: WKInterfaceTable!

    var scholars = NSMutableArray()
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var defaults = NSUserDefaults(suiteName: "group.wwdcscholars.2015")
        
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
            WKInterfaceController.openParentApplication(["scholar_request": "dummy_val"]) { userInfo, error in
                println("User Info: \(userInfo)")
                println("Error: \(error)")
                
                if let success = (userInfo as? [String: AnyObject])?["success"] as? NSNumber {
                    if success.boolValue == true {
                        var allScholarsJson = (userInfo as NSDictionary).objectForKey("scholars") as! NSArray
                        for dict: NSDictionary in allScholarsJson as! [NSDictionary]{
                            var scholar = Scholar(name: dict.objectForKey("name") as? String,
                                age: dict.objectForKey("age") as! Int,
                                latitude: dict.objectForKey("latitude") as! Double,
                                longitude: dict.objectForKey("longitude") as! Double,
                                picture: dict.objectForKey("picture") as? String,
                                shortBio: dict.objectForKey("shortBio") as? String,
                                numberOfWWDCAttend: dict.objectForKey("numberOfWWDCAttend") as? Int,
                                location: dict.objectForKey("location") as? String)
                            self.scholars.addObject(scholar)
                            println(scholar)
                        }
                        println("Loaded \(allScholarsJson.count) scholars")
                        
                        self.loadTableData()

                    }
                }
            }
            
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
                    row.scholarImage.setImage(UIImage(data: NSData(contentsOfURL: applicationDocumentsDirectory!.URLByAppendingPathComponent(scholar.name!.stringByReplacingOccurrencesOfString(" ", withString: "")))!))
//                    row.scholarImage=row.scholarImage.setImageWithUrl(profilePic)
                }
            }
        }
    }
    lazy var applicationDocumentsDirectory: NSURL? = {
        return NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.wwdcscholars.2015") ?? nil
        }()
}
