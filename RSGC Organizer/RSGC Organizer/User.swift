//
//  User.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-03-21.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import Foundation
import Alamofire

class User {
    var username : String?
    var firstName : String?
    var lastName : String?
    var email : String?
    var id : Int?
    
    init(username : String, first : String, last : String, email : String, idNum : Int) { // init function allowing the input of raw values for this class (avoid use if possible as information can be entered with corresponding user in the database)
        self.username = username
        self.lastName = last
        self.firstName = first
        self.email = email
        self.id = idNum
    }
    
    init(endpointURL : String, id : Int) {
        Alamofire.request(endpointURL, method: .get).responseJSON { response in
            if let result = response.result.value {
                let JSONResponse = result as! NSDictionary // we know the object returned when specifically accessing a certain user is a dictionary
                // extract values from dictionary
                self.username = JSONResponse["username"] as! String
                self.firstName = JSONResponse["first_name"] as! String
                self.lastName = JSONResponse["last_name"] as! String
                self.email = JSONResponse["email"] as! String
                self.id = JSONResponse["id"] as! Int
            }
        }
    }
}
