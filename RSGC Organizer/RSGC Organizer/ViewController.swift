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
//        let parameters : [String : Any] = [ // Dictionary containing the static data I want to send to my database as a test
//            "username":"ALAMO_FIRE_POST",
//            "password":"FIRE",
//            "first_name":"REMEMBER THE",
//            "last_name":"ALAMO!",
//            "email":"alamo@fire.com"
//        ]
//        //                TEMP URL of Local Debug server
//        Alamofire.request("http://127.0.0.1:8000/register/", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in // Alamo Fire library request() call to make a POST request with the parameters I gave above and return the JSON response from the server
//            print(response)
//            // parse response
//            if let resultVal = response.result.value {
//                let JSON = resultVal as? NSDictionary
//                print(JSON)
//                print(JSON?["last_name"])
//            }
        let user = "admin"
        let password = "Gate5416"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Alamofire.request("http://127.0.0.1:8000/get_student/", headers: headers)
            .responseJSON { response in
                debugPrint(response)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
