//
//  Global.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-02-06.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import Foundation


class Global { // Will store global variables that must be accessible accross all view controllers
    
    static let scheduleArray : [[Int]] = [
    
        [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 4, 1, 2, 3, 9, 9, 4, 1, 2, 3, 4, 9, 9, 1, 2, 3, 4, 1, 9, 9, 2, 3], // January
        [9, 4, 1, 2, 9, 9, 3, 4, 1, 2, 3, 9, 9, 4, 1, 2, 3, 9, 9, 9, 9, 4, 1, 2, 3, 9, 9, 4, 1],           // February
        [9, 2, 3, 4, 9, 9, 1, 2, 3, 4, 1, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 2, 3, 4, 1],  // March
        [9, 9, 9, 2, 3, 4, 1, 2, 9, 9, 3, 4, 1, 2, 9, 9, 9, 9, 3, 4, 1, 2, 9, 9, 3, 4, 1, 2, 3, 9, 9],   // April
        [9, 4, 1, 2, 3, 4, 9, 9, 1, 2, 3, 4, 1, 9, 9, 2, 3, 4, 1, 2, 9, 9, 9, 3, 4, 1, 2, 9, 9, 3, 4, 1], // May
        [9, 2, 3, 9, 9, 4, 1, 2, 3, 4, 9, 9, 1, 2, 3, 4, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],    // June
        [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],   // July
        [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],   // August
        [9, 9, 9, 9, 9, 9, 9, 0, 1, 2, 9, 9, 3, 4, 1, 2, 3, 9, 9, 4, 1, 2, 3, 0, 9, 9, 4, 1, 2, 3, 4],  // September
        [9, 9, 9, 1, 2, 3, 4, 1, 9, 9, 0, 2, 3, 4, 1, 9, 9, 2, 3, 4, 1, 2, 9, 9, 3, 4, 1, 2, 3, 9, 9, 4], // October
        [9, 1, 2, 3, 4, 9, 9, 1, 2, 3, 4, 9, 9, 9, 9, 1, 2, 3, 4, 9, 9, 1, 2, 3, 4, 1, 9, 9, 2, 3, 4],    // November
        [9, 1, 2, 9, 9, 3, 4, 1, 2, 3, 9, 9, 4, 1, 2, 3, 4, 9, 9, 1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9] // December
        // Day Calendar 2016 - 2017
    ]
    
    static var user : User?
    
    static let apiRoot : String = "http://127.0.0.1:8000"//"http://petersonbackend.duckdns.org:8000"
    
    static var registrationStatus : Bool = false
    
    static var username : String? // holds username and password when authentication is needed in different parts of the the application
    static var password : String?
    
    init() { } // Nothing to initialize so far
    
    // Write functions to return time variables used in determining day number
    
    static let minute : () -> (Int) = {
        let date = NSDate()
        let calendar = NSCalendar.current
        let min = calendar.component(.minute, from: date as Date)
        return min
    }
    
    static let hour : () -> (Int) = {
        let date = NSDate()
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: date as Date)
        return hour
    }
    
    static let day : () -> (Int) = {
        let date = NSDate()
        let calendar = NSCalendar.current
        let day = calendar.component(.day, from: date as Date)
        return day
    }
    
    static let month : () -> (Int) = {
        let date = NSDate()
        let calendar = NSCalendar.current
        let month = calendar.component(.month, from: date as Date)
        return month
    }
    
    static let dateString : (NSDate) -> (String) = { date in
        let calendar = NSCalendar.current
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date as Date)
    }
    
    static let dayNum : () -> (Int) = {
        return scheduleArray[month() - 1][day()]
    }
    
    static let saveData : ([String : Any], String) -> (Bool) = { (dictionary, key) in
        let archived = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        UserDefaults.standard.set(archived, forKey: key)
        return UserDefaults.standard.synchronize()
    }
    
    static let getData : (String) -> ([String : Any]?) = { key in
        
        // get the data using a guard let in case it is not there
        guard let data = UserDefaults.standard.object(forKey: key) else {
            return nil
        }
        
        // Check if the data has the correct type using a guard let statement
        guard let retrievedData = data as? Data else {
            return nil
        }
        
        // unarchive the dictionary
        let unarchivedObject = NSKeyedUnarchiver.unarchiveObject(with: retrievedData)
        return unarchivedObject as? [String: Any]
    }
    
    //NOTE: More global variables will be added as they are needed
}
