//
//  AppDelegate.swift
//  WWDC Scholars 2015
//
//  Created by Gelei Chen on 15/5/20.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit
import Parse
import ParseCrashReporting
import Bolts
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
                
        Parse.enableLocalDatastore()
        
        ParseCrashReporting.enable();

        Parse.setApplicationId("16ktYTkz6kuPyT81SZtxP4CXDV0POwVV5szF7kYP",
            clientKey: "Ev89WaE9EVFmNXh6HB6LXLlJArnsG74PwiF8gbMT")
        
        // Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        // Load all dem scholarship winners! :D
        DataManager.sharedInstance.loadStudents()
    
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(
        application: UIApplication,
        handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?,
        reply: (([NSObject : AnyObject]!) -> Void)!)
    {
        if let pfqueryRequest: AnyObject = (userInfo as? [String: AnyObject])?["pfquery_request"] {
            println("Starting PFQuery") // won't print out to console since you're running the watch extension
            
            var male = 0
            var female = 0
            var totalAge = 0
            var youngestAge = 0
            var oldestAge = 0
            var query = PFQuery(className:"scholars")
            
            var objects = query.findObjects()

                    println("Successfully retrieved \(objects!.count) scholars.")
                    if let objects = objects as? [PFObject] {
                        for object in objects {
                            var age = object.objectForKey("age") as! Int
                            
                            if (youngestAge == 0){
                                youngestAge = age
                            }
                            if (oldestAge == 0){
                                oldestAge = age
                            }
                            if (age > oldestAge){ oldestAge = age }
                            if (age < youngestAge){ youngestAge = age }
                            totalAge += (object.objectForKey("age") as! Int)
                            if (object.objectForKey("gender") as? String == "Male"){
                                male += 1
                            }
                            if (object.objectForKey("gender") as? String == "Female"){
                                female += 1
                            }
                            
                        }
                        
                        println(male)
                        println(female)
                        
                        let averageAge = totalAge/objects.count
                        reply(["success": true, "totalWinners":objects.count, "male": male, "female": female, "averageAge": averageAge, "oldest": oldestAge, "youngest": youngestAge])
                        
//                } else {
//                    // Log details of the failure
//                    println("Error: \(error!) \(error!.userInfo!)")
//                }
            }

        }else if let pfqueryRequest: AnyObject = (userInfo as? [String: AnyObject])?["scholar_request"]{
            if let containerURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.wwdcscholars.2015") {
            var scholarsArray = NSMutableArray()
            var query = PFQuery(className:"scholars")
            
            var objects = query.findObjects()
            
            println("Successfully retrieved \(objects!.count) scholars.")
            if let objects = objects as? [PFObject] {
                for object in objects {
            var scholar = Scholar(
                name: NSString(format: "%@ %@", object.objectForKey("firstName") as! String, object.objectForKey("lastName") as! String) as String,
                age: object.objectForKey("age") as! Int,
                birthdate: object.objectForKey("birthday") as? NSDate,
                gender: object.objectForKey("gender") as? String,
                latitude: (object.objectForKey("latitude") as? Double)!,
                longitude: (object.objectForKey("longtitude") as? Double)!,
                email: object.objectForKey("email") as? String,
                picture: (object.objectForKey("smallPicture") as! PFFile).url!,
                appScreenshots:nil,
                shortBio: object.objectForKey("shortBio") as? String,
                numberOfWWDCAttend: object.objectForKey("numberOfTimesWWDCScholar") as? Int,
                appDemo: object.objectForKey("videoLink") as? String,
                githubLinkToApp: object.objectForKey("githubLinkApp") as? String,
                twitter: object.objectForKey("twitter") as? String,
                facebook: object.objectForKey("facebook") as? String,
                github: object.objectForKey("github") as? String,
                linkedIn: object.objectForKey("linkedin") as? String,
                website: object.objectForKey("website") as? String,
                location:object.objectForKey("location") as? String,
                itunes:object.objectForKey("itunes") as? String)
                    scholarsArray.addObject(scholar.generateSimpleJson())
                    
                    if let imageUrl = NSURL(string: (object.objectForKey("smallPicture") as! PFFile).url!) {
                        // create your document folder url
                        let documentsUrl = self.applicationDocumentsDirectory!
                        // your destination file url
                        let destinationUrl = documentsUrl.URLByAppendingPathComponent(scholar.name!.stringByReplacingOccurrencesOfString(" ", withString: ""))
                        println(destinationUrl)
                        // check if it exists before downloading it
                        if NSFileManager().fileExistsAtPath(destinationUrl.path!) {
                            println("The file already exists at path")
                        } else {
                            //  if the file doesn't exist
                            //  just download the data from your url
                            if let myAudioDataFromUrl = NSData(contentsOfURL: imageUrl){
                                // after downloading your data you need to save it to your destination url
                                if myAudioDataFromUrl.writeToURL(destinationUrl, atomically: true) {
                                    println("file saved")
                                } else {
                                    println("error saving file")
                                }
                            }
                        }
                    }
                    
            }
                reply(["success": true, "scholars":scholarsArray as NSArray as! [NSDictionary]])
            }
            reply(["success": false, "scholars":[]])
            }
        }
    }

        lazy var applicationDocumentsDirectory: NSURL? = {
            return NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.wwdcscholars.2015") ?? nil
            }()
}

