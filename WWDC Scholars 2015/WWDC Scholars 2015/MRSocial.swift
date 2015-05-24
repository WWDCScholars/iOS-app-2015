//
//  MRSocial.swift
//  Nicola Giancecchi
//
//  Created by Nicola Giancecchi on 14/04/15.
//  Copyright (c) 2015 Nicola Giancecchi. All rights reserved.
//

import UIKit

class MRSocial: NSObject {
    
    
    private static func openLinkWithPattern(pattern:String, contentId:String){
        MRSocial.openLinkWithAppPattern(pattern, webPattern: pattern, contentId: contentId)
    }
    
    private static func openLinkWithAppPattern(appPattern:String, webPattern:String, contentId:String){
        var url : NSURL = NSURL(string: appPattern.stringByAppendingString(contentId))!
        if !UIApplication.sharedApplication().canOpenURL(url){
            url = NSURL(string: webPattern.stringByAppendingString(contentId))!
        }
        UIApplication.sharedApplication().openURL(url)
    }
    
    
    /*
    YOUTUBE - User Channel
    Open in app:               youtube://www.youtube.com/user/UID
    Open in Safari:            http://www.youtube.com/user/UID
    */
    static func openYouTubePage(pageId:String){
        MRSocial.openLinkWithAppPattern("youtube://www.youtube.com/user/", webPattern: "http://www.youtube.com/user/", contentId: pageId)
    }
    
    
    /*
    YOUTUBE - Video
    Open in app or Safari:     http://www.youtube.com/watch?v=VID
    */
    static func openYouTubeVideo(videoId:String){
        MRSocial.openLinkWithPattern("http://www.youtube.com/watch?v=", contentId: videoId)
    }
    
    /*
    INSTAGRAM - User Profile
    Docs:                      http://instagram.com/developer/mobile-sharing/iphone-hooks/
    Open in app:               instagram://user?username=UID
    Open in Safari:            http://www.instagram.com/UID
    */
    static func openInstagramProfile(profileId:String){
        MRSocial.openLinkWithAppPattern("instagram://user?username=", webPattern: "http://www.instagram.com/", contentId: profileId)
    }
    
    /*
    FACEBOOK - Profile and Pages
    Profile ID *MUST* be numeric!!!
    Open in app:               fb://profile/PID
    Open in Safari:            http://www.facebook.com/PID
    */
    static func openFacebookProfile(profileId:String){
        MRSocial.openLinkWithAppPattern("fb://profile/", webPattern: "http://www.facebook.com/", contentId: profileId)
    }
    
    /*
    TWITTER - Profile
    Open in app:               twitter://user?screen_name=PID
    Open in Safari:            http://www.twitter.com/PID
    */
    static func openTwitterProfile(profileId:String){
        MRSocial.openLinkWithAppPattern("twitter://user?screen_name=", webPattern: "http://www.twitter.com/", contentId: profileId)
    }
    
}
