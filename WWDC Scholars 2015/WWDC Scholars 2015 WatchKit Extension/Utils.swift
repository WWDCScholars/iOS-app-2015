//
//  Utils.swift
//  WWDC Scholars 2015
//
//  Created by Matthijs Logemann on 24-05-15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit
import WatchKit

class Utils: NSObject {
   
}

public extension WKInterfaceImage {
    
    public func setImageWithUrl(url:String) -> WKInterfaceImage? {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let url:NSURL = NSURL(string:url)!
            var data:NSData = NSData(contentsOfURL: url)!
            var placeholder = UIImage(data: data)!
            
            dispatch_async(dispatch_get_main_queue()) {
                self.setImage(placeholder)
            }
        }
        
        return self
    }
    
}
