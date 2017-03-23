//
//  User.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-03-21.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import Foundation

class User {
    var username : String!
    var firstName : String!
    var lastName : String!
    var email : String!
    var id : Int!
    var rawData : NSDictionary!
    
    var student : Student?
    
    init(username : String, first : String, last : String, email : String, idNum : Int) { // init function allowing the input of raw values for this class (avoid use if possible as information can be entered with corresponding user in the database)
        self.username = username
        self.lastName = last
        self.firstName = first
        self.email = email
        self.id = idNum
    }
    
    init(data : NSDictionary) {
        self.rawData = data
        self.username = data["username"] as! String
        self.firstName = data["first_name"] as! String
        self.lastName = data["last_name"] as! String
        self.id = data["id"] as! Int
    }
}
