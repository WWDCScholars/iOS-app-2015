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
    var longitude : Double
    var latitude : Double
    var shortBio : String?
    var picture : String?
    var numberOfWWDCAttend : Int?
    var location : String?
    
    init(name:String?,age:Int,latitude:Double,longitude:Double,picture:String?, shortBio:String?,numberOfWWDCAttend:Int?,location:String?){
        self.name = name
        self.age = age
        
        self.longitude = longitude
        self.latitude = latitude
        self.picture = picture
        self.shortBio = shortBio
        if shortBio == nil {
            self.shortBio = ""
        }
        self.numberOfWWDCAttend = numberOfWWDCAttend
        self.location = location
    }
}