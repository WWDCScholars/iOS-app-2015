//
//  Scholar.swift
//  WWDC Scholars 2015
//
//  Created by Gelei Chen on 15/5/20.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import Foundation

class Scholar:NSObject{
    
    var name : String?
    var age : Int?
    var birthdate : NSDate?
    var gender : String?
    var longitude : Double
    var latitude : Double
    var email : String?
    var shortBio : String?
    var picture : String?
    var appScreenshots: [String]?
    var numberOfWWDCAttend : Int?
    var appDemo : String?
    var githubLinkToApp : String?
    var twitter : String?
    var facebook : String?
    var github : String?
    var linkedIn : String?
    var website : String?
    var location : String?
    var itunes : String?
    var user : PFUser?
    
    init(name:String?,age:Int,birthdate:NSDate?,gender:String?,latitude:Double,longitude:Double,email:String?,picture:String?, appScreenshots:[String]?,shortBio:String?,numberOfWWDCAttend:Int?,appDemo:String?,githubLinkToApp:String?,twitter:String?,facebook:String?,github:String?,linkedIn:String?,website:String?,location:String?, user: PFUser?,  itunes: String?){
        self.name = name
        self.age = age
        self.birthdate = birthdate
        self.gender = gender
        self.longitude = longitude
        self.latitude = latitude
        self.email = email
        self.picture = picture
        self.appScreenshots = appScreenshots
        self.shortBio = shortBio
        self.numberOfWWDCAttend = numberOfWWDCAttend
        self.appDemo = appDemo
        self.githubLinkToApp = githubLinkToApp
        self.twitter = twitter
        self.facebook = facebook
        self.github = github
        self.linkedIn = linkedIn
        self.website = website
        self.location = location
        self.itunes = itunes
            self.user = user
    }
}