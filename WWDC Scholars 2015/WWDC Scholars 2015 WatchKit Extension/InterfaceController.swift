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
    
    @IBOutlet var scholarAmount: WKInterfaceLabel!
    @IBOutlet var mostCommonCity: WKInterfaceLabel!
    @IBOutlet var maleFemaleRatio: WKInterfaceLabel!
    @IBOutlet var averageAge: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        
        
        var mfRatioText = NSMutableAttributedString()
        mfRatioText.appendAttributedString(NSAttributedString(string: String.fontAwesomeIconWithName(FontAwesome.Male), attributes: [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!))
        mfRatioText.appendAttributedString(NSAttributedString(string: ": 0     ", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(20)] as Dictionary!))
        
        mfRatioText.appendAttributedString(NSAttributedString(string: String.fontAwesomeIconWithName(FontAwesome.Female), attributes: [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!))
        mfRatioText.appendAttributedString(NSAttributedString(string: ": 0", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(20)] as Dictionary!))
        
        maleFemaleRatio.setAttributedText(mfRatioText)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
            WKInterfaceController.openParentApplication(["pfquery_request": "dummy_val"]) { userInfo, error in
                println("User Info: \(userInfo)")
                println("Error: \(error)")
                
                var data = (userInfo as NSDictionary)
                
                if let success = data["success"] as? NSNumber {
                    if success.boolValue == true {
                        var male = data.objectForKey("male") as! NSNumber
                        var female = data.objectForKey("female") as! NSNumber
                        var total = data.objectForKey("totalWinners") as! NSNumber
                        var averageAge = data.objectForKey("averageAge") as! NSNumber

                        var mfRatioText = NSMutableAttributedString()
                        mfRatioText.appendAttributedString(NSAttributedString(string: String.fontAwesomeIconWithName(FontAwesome.Male), attributes: [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!))
                        mfRatioText.appendAttributedString(NSAttributedString(string: ": \(male)     ", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(20)] as Dictionary!))
                        
                        mfRatioText.appendAttributedString(NSAttributedString(string: String.fontAwesomeIconWithName(FontAwesome.Female), attributes: [NSFontAttributeName: UIFont.fontAwesomeOfSize(20)] as Dictionary!))
                        mfRatioText.appendAttributedString(NSAttributedString(string: ": \(female)", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(20)] as Dictionary!))
                        
                        self.maleFemaleRatio.setAttributedText(mfRatioText)
                        
                        self.scholarAmount.setText("\(total) out of 350")
                        self.averageAge.setText(averageAge.description)
                    }
                }
            }
            
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func goToScholars() {
        self.pushControllerWithName("scholars", context: nil)
    }
}
