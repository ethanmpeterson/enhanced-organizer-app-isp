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
    var dayNumber : Int!
    
    var p1 : String!
    var p2 : String!
    var p3 : String!
    var p4 : String!
    
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
        // collect other revalent info from the backend data as class properties
        self.id = data["id"] as! Int
        self.studentId = data["student"] as! Int
        self.rawData = data
        self.dayNumber = Global.dayNum()
        
        // assign classes based on date and time
        if (self.dayNumber == 9) {
            self.p1 = "Holiday"
            self.p2 = "Holiday"
            self.p3 = "Holiday"
            self.p4 = "Holiday"
        } else if (self.dayNumber == 0) {
            self.p1 = "Special Event"
            self.p2 = "Special Event"
            self.p3 = "Special Event"
            self.p4 = "Special Event"
        } else {
            self.p1 = self.classes["d\(self.dayNumber)p1"]
            self.p2 = self.classes["d\(self.dayNumber)p2"]
            self.p3 = self.classes["d\(self.dayNumber)p3"]
            self.p4 = self.classes["d\(self.dayNumber)p4"]
        }
    }
    
    func update(_ dayNum : Int) { // updates the current schedule data based on current date and time takes dayNum as input in case the user has changed the date and the schedule for that date must be collected
        if (self.dayNumber == 9) {
            self.p1 = "Holiday"
            self.p2 = "Holiday"
            self.p3 = "Holiday"
            self.p4 = "Holiday"
        } else if (self.dayNumber == 0) {
            self.p1 = "Special Event"
            self.p2 = "Special Event"
            self.p3 = "Special Event"
            self.p4 = "Special Event"
        } else {
            self.p1 = self.classes["d\(self.dayNumber)p1"]
            self.p2 = self.classes["d\(self.dayNumber)p2"]
            self.p3 = self.classes["d\(self.dayNumber)p3"]
            self.p4 = self.classes["d\(self.dayNumber)p4"]
        }
    }
}
