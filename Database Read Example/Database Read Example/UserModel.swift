//
//  UserModel.swift
//  Database Read Example
//
//  Created by Ethan Peterson on 2017-03-06.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import Foundation

class UserModel : NSObject {
    var first : String?
    var last : String?
    var mail : String?
    
    override init() {} // empty constructor
    
    init(firstName : String, lastName : String, email : String) { // construct with db specific parameters instead
        self.first = firstName
        self.last = lastName
        self.mail = email
    }
}
