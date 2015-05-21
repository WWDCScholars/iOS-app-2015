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
    var birthdate : String?
    var gender : String?
    var longitude : Double
    var latitude : Double
    var email : String?
    var picture : String?
    var numberOfWWDCAttend : Int?
    var appDemo : String?
    var githubLinkToApp : String?
    var twitter : String?
    var facebook : String?
    var github : String?
    var linkedIn : String?
    var website : String?
    
    init(name:String?,age:Int,birthdate:String?,gender:String?,latitude:Double,longitude:Double,email:String?,picture:String?,numberOfWWDCAttend:Int?,appDemo:String?,githubLinkToApp:String?,twitter:String?,facebook:String?,github:String?,linkedIn:String?,website:String?){
            self.name = name
            self.age = age
            self.birthdate = birthdate
            self.gender = gender
            self.longitude = longitude
            self.latitude = latitude
            self.email = email
            self.picture = picture
            self.numberOfWWDCAttend = numberOfWWDCAttend
            self.appDemo = appDemo
            self.githubLinkToApp = githubLinkToApp
            self.twitter = twitter
            self.facebook = facebook
            self.github = github
            self.linkedIn = linkedIn
            self.website = website
        }
}