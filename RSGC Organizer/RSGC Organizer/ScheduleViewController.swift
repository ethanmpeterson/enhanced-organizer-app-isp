//
//  ScheduleViewController.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-03-21.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import UIKit
import Alamofire

class ScheduleViewController: UIViewController {
    
    var user : User? //= User(username: "ERROR", first: "PLACEHOLDER", last: "McPlaceHolder", email: "place@holder.com", idNum: 0)
    var dataPassed : NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        // Do any additional setup after loading the view.
        //let userId = dataPassed?["user"] as! Int
        print(dataPassed)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
