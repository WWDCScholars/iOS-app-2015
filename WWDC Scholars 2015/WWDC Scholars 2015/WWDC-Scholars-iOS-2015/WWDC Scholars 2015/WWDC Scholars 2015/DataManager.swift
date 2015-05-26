//
//  DataManager.swift
//  WWDC Scholars 2015
//
//  Created by Matthijs Logemann on 21-05-15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import Parse
import Bolts

class DataManager: NSObject {
    
    var scholarArray = NSMutableArray()
    
    class var sharedInstance: DataManager {
        struct Static {
            static let instance: DataManager = DataManager()
        }
        return Static.instance
    }
    
    func loadStudents(){
        var query = PFQuery(className:"scholars")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.scholarArray.removeAllObjects()
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scholars.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        var scholar = Scholar(
                            name: NSString(format: "%@ %@", object.objectForKey("firstName") as! String, object.objectForKey("lastName") as! String) as String,
                            age: object.objectForKey("age") as! Int,
                            birthdate: "",
                            gender: object.objectForKey("gender") as? String,
                            latitude: 0.0,
                            longitude: 0.0,
                            email: object.objectForKey("email") as? String,
                            picture: (object.objectForKey("profilePic") as! PFFile).url!,
                            numberOfWWDCAttend: object.objectForKey("numberOfTimesWWDCScholar") as? Int,
                            appDemo: object.objectForKey("videoLink") as? String,
                            githubLinkToApp: object.objectForKey("githubLinkApp") as? String,
                            twitter: object.objectForKey("twitter") as? String,
                            facebook: object.objectForKey("facebook") as? String,
                            github: object.objectForKey("github") as? String,
                            linkedIn: object.objectForKey("linkedin") as? String,
                            website: object.objectForKey("website") as? String)
                        self.scholarArray.addObject(scholar)
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
}
