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
    
    var schedule : Schedule?
    
    init(grade : Int, id : Int, ownerId : Int, schedule : Schedule) {
        self.grade = grade
        self.id = id
        self.ownerId = ownerId
        self.schedule = schedule
    }
    
    init(data : NSDictionary) {
        self.grade = data["grade"] as! Int
        self.id = data["id"] as! Int
        self.ownerId = data["user"] as! Int
    }
}
