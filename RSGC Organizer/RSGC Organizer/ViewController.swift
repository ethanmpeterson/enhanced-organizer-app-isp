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

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
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
        
        
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) { // code runs when login button is pressed
        let user = usernameInput.text
        let password = passwordInput.text
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user!, password: password!) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Alamofire.request("http://127.0.0.1:8000/get_student/", headers: headers)
            .responseJSON { response in
                if (response.result.isSuccess) {
                    // parse response to ensure that there is a student ascociated with the user
                    if let resultVal = response.result.value {
                        let JSON = resultVal as? NSArray
                        if (JSON?[0] != nil) {
                            let student = JSON?[0] as! NSDictionary // initialize student object returned in JSON as a dictionary
                            
                            // navigate to schedule view controller
                            //scheduleViewObject.dataPassed = student
                            let id = student["user"] as! Int
                            Alamofire.request("http://127.0.0.1:8000/users/\(id)/", method: .get).responseJSON { response in
                                if let rawValue = response.result.value {
                                    // Get schedule of user
                                    let studentId = student["id"] as! Int
                                    let params : [String : Any] = [
                                        "student":studentId
                                    ]
                                    Alamofire.request("http://127.0.0.1:8000/get_schedule/", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
                                        if response.result.isSuccess {
                                            if let rawResult = response.result.value {
                                                let JSONScheduleResponse = rawResult as? NSDictionary
                                                let scheduleId = JSONScheduleResponse?["id"] as! Int
                                                // build complete user object and 
//                                                let scheduleViewObject = self.storyboard?.instantiateViewController(withIdentifier: "scheduleView") as! ScheduleViewController
//                                                self.navigationController?.pushViewController(scheduleViewObject, animated: true)
                                                // get a hold of schedule
                                                Alamofire.request("http://127.0.0.1:8000/schedules/\(scheduleId)/", method: .get).responseJSON { response in
                                                    if let rawVal = response.result.value {
                                                        let rawScheduleData = rawVal as? NSDictionary
                                                        // build complete user object and navigate to main View Controller with Schedule display
                                                        print(rawScheduleData)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            let alert = UIAlertController(title: "Alert", message: "Invalid Credentials", preferredStyle: UIAlertControllerStyle.alert) // show error message if incorrect login is provided
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    let alert = UIAlertController(title: "Alert", message: "Connection to Server Failed", preferredStyle: UIAlertControllerStyle.alert) // show error message if the request failed
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
