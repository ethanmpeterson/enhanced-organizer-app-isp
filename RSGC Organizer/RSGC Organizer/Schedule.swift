//
//  Schedule.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-02-06.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import Foundation

class Schedule {
    let classes : [String : String]!
    let id : Int!
    let studentId : Int!
    let rawData : NSDictionary!
    
    init(data : NSDictionary) {
        self.classes = [ // create dictionary of student's classes for all 4 days of the cycle as opposed to 2
            // day 1
            "d1p1" : data["d1p1"] as! String,
            "d1p2" : data["d1p2"] as! String,
            "d1p3" : data["d1p3"] as! String,
            "d1p4" : data["d1p4"] as! String,
            
            // day 2
            "d2p1" : data["d2p1"] as! String,
            "d2p2" : data["d2p2"] as! String,
            "d2p3" : data["d2p3"] as! String,
            "d2p4" : data["d2p4"] as! String,
            
            // day 3
            "d3p1" : data["d1p4"] as! String,
            "d3p2" : data["d1p2"] as! String,
            "d3p3" : data["d1p3"] as! String,
            "d3p4" : data["d1p1"] as! String,
            
            // day 4
            "d4p1" : data["d2p4"] as! String,
            "d4p2" : data["d2p2"] as! String,
            "d4p3" : data["d2p3"] as! String,
            "d4p4" : data["d2p1"] as! String
        ]
        self.id = data["id"] as! Int
        self.studentId = data["student"] as! Int
        self.rawData = data
    }
    
}
