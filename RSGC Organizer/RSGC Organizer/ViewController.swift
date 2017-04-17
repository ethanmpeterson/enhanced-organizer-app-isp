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
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var register: UIButton!
    
    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController!.navigationBar.barTintColor = UIColor(red: 220.0 / 255, green: 184.0 / 255, blue: 72.0/255, alpha: 100.0 / 100.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        login.layer.cornerRadius = 15
        register.layer.cornerRadius = 15
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) { // code runs when login button is pressed
        let user = usernameInput.text
        let password = passwordInput.text
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user!, password: password!) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        
        Alamofire.request("\(Global.apiRoot)/get_student/", headers: headers)
            .responseJSON { response in
                print(response.result)
                if (response.result.isSuccess) {
                    // parse response to ensure that there is a student ascociated with the user
                    if let resultVal = response.result.value {
                        let JSON = resultVal as? NSArray
                        if (JSON?[0] != nil) {
                            let studentData = JSON?[0] as! NSDictionary // initialize student object returned in JSON as a dictionary
                            print(studentData)
                            // navigate to schedule view controller
                            //scheduleViewObject.dataPassed = student
                            let id = studentData["user"] as! Int
                            Alamofire.request("\(Global.apiRoot)/users/\(id)/", method: .get).responseJSON { response in
                                if let rawValue = response.result.value {
                                    let userData = rawValue as! NSDictionary
                                    let studentId = studentData["id"] as! Int
                                    let params : [String : Int] = [
                                        "student" : studentId,
                                    ]
                                    Alamofire.request("\(Global.apiRoot)/get_schedule/", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
                                        if response.result.isSuccess {
                                            if let rawResult = response.result.value {
                                                let JSONScheduleResponse = rawResult as? NSDictionary
                                                let scheduleId = JSONScheduleResponse?["id"] as! Int
                                                // get a hold of schedule
                                                Alamofire.request("\(Global.apiRoot)/schedules/\(scheduleId)/", method: .get).responseJSON { response in
                                                    if let rawVal = response.result.value {
                                                        let rawScheduleData = rawVal as! NSDictionary
                                                        // build complete user object and navigate to main View Controller with Schedule display
                                                        print(rawScheduleData)
                                                        let schedule = Schedule(data: rawScheduleData)
                                                        let student = Student(data: studentData, schedule: schedule)
                                                        print(studentData)
                                                        Global.user = User(data: userData, student: student)
                                                        // present new view controller to display the schedule now that all user data has been collected
                                                        let scheduleViewObject = self.storyboard?.instantiateViewController(withIdentifier: "scheduleView") as! ScheduleViewController // prepare view controller object
                                                        self.navigationController?.pushViewController(scheduleViewObject, animated: true) // present schedule view controller
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
    
    
    @IBAction func registerButton(_ sender: UIButton) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
