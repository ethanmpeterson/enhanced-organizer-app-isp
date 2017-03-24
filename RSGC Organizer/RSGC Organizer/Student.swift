//
//  Student.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-02-06.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import Foundation

class Student {
    
    let grade : Int!
    let id : Int!
    let ownerId : Int!
    let rawData : NSDictionary?
    var schedule : Schedule?
    
    init(data : NSDictionary) {
        self.grade = Int(data["grade"] as! String)
        self.id = data["id"] as! Int
        self.ownerId = data["user"] as! Int
        self.rawData = data
    }
    
    init(data : NSDictionary, schedule : Schedule) {
        self.grade = Int(data["grade"] as! String)
        self.id = data["id"] as! Int
        self.ownerId = data["user"] as! Int
        self.schedule = schedule
        self.rawData = data
    }
}
