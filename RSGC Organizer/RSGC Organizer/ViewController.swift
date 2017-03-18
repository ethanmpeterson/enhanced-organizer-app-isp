//
//  ViewController.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-02-02.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//


import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let parameters : [String : Any] = [
            "username":"ALAMO_FIRE_POST",
            "password":"FIRE",
            "first_name":"REMEMBER THE",
            "last_name":"ALAMO!",
            "email":"alamo@fire.com"
        ]
        Alamofire.request("http://127.0.0.1:8000/register/", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
//        Alamofire.request("https://ethanpeterson.tech/service.php").responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
//
//    }


    }
}
