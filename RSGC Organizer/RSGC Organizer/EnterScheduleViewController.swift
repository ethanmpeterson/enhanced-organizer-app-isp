//
//  EnterScheduleViewController.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-04-10.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import UIKit
import Alamofire

class EnterScheduleViewController: UIViewController {
    
    var registeredUser : User!
    var grade : String!
    var scheduleParams : [String : Any] = [:]
    var timesPressed = 0 // variable counting how many times the next button is pressed to know when the user has entered all of their schedule data
    
    var fromSettings : Bool = false
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var p1Field: UITextField!
    @IBOutlet weak var p2Field: UITextField!
    @IBOutlet weak var p3Field: UITextField!
    @IBOutlet weak var p4Field: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController!.navigationBar.barTintColor = UIColor(red: 190.0 / 255, green: 25.0 / 255, blue: 46.0 / 255, alpha: 100.0 / 100.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (!self.fromSettings) {
            self.navigationItem.setHidesBackButton(true, animated : true)
        }
        // Do any additional setup after loading the view.
        nextButton.layer.cornerRadius = 15
        // setup params dictionary
        for i in 1 ... 2 {
            for j in 1 ... 4 {
                scheduleParams["d\(i)p\(j)"] = ""
            }
        }
        print(self.fromSettings)
    }

    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func nextPressed(_ sender: UIButton) {
        if (p1Field.text != nil && p2Field.text != nil && p3Field.text != nil && p4Field.text != nil) {
            if (timesPressed == 0) {
                //vardate the view
                timesPressed += 1
                p1Field.placeholder = "Day 2 Period 1 Class" // change placeholder text to tell user that they should enter day 2 classes
                p2Field.placeholder = "Day 2 Period 2 Class"
                p3Field.placeholder = "Day 2 Period 3 Class"
                p4Field.placeholder = "Day 2 Period 4 Class"
                nextButton.setTitle("Finish", for: .normal)
                
                // update params dictionary with new data
                scheduleParams["d1p1"] = p1Field.text!
                scheduleParams["d1p2"] = p2Field.text!
                scheduleParams["d1p3"] = p3Field.text!
                scheduleParams["d1p4"] = p4Field.text!
                
                // clear text in fields so user can enter day 2 classes
                p1Field.text = nil
                p2Field.text = nil
                p3Field.text = nil
                p4Field.text = nil
            } else {
                // update params dictionary
                scheduleParams["d2p1"] = p1Field.text!
                scheduleParams["d2p2"] = p2Field.text!
                scheduleParams["d2p3"] = p3Field.text!
                scheduleParams["d2p4"] = p4Field.text!
                
                // make Alamofire calls to add schedule data and show schedule view controller
                if (!self.fromSettings) {
                    completeRegistration()
                } else {
                    updateSchedule()
                }
            }
        }
    }
    
    func completeRegistration() { // completes user registration by posting the schedule data to the database returns bool to say whether it was a success or not
        let studentParams : [String : Any] = [
            "user" : registeredUser.id,
            "grade" : grade
        ]
        Alamofire.request("\(Global.apiRoot)/create_student/", method: .post, parameters: studentParams, encoding: JSONEncoding.default).responseJSON { response in
            if response.result.isSuccess {
                if response.response?.statusCode == 201 { // check if student has successfully been created
                    // build student object
                    let createdStudent : Student = Student(data: response.result.value as! NSDictionary)
//                    if let studentJSON = response.result.value {
//                        let studentData = studentJSON as! NSDictionary
//                        createdStudent = Student(data: studentData)
//                    }
                    self.scheduleParams["student"] = createdStudent.id // add student to schedule params now that it has been created
                    
                    Alamofire.request("\(Global.apiRoot)/create_schedule/", method: .post, parameters: self.scheduleParams, encoding: JSONEncoding.default).responseJSON { response in // create schedule based on data entered
                        if response.result.isSuccess {
                            if response.response?.statusCode == 201 {
                                let createdSchedule : Schedule!
                                if let scheduleJSON = response.result.value {
                                    let scheduleData = scheduleJSON as! NSDictionary
                                    createdSchedule = Schedule(data: scheduleData)
                                    Global.registrationStatus = true // indicate that registration was successful
                                    
                                    // add newly created student and schedule to registered user
                                    self.registeredUser.student = createdStudent
                                    self.registeredUser.student?.schedule = createdSchedule
                                    
                                    // pass new User to the global class and show schedule view controller
                                    Global.user = self.registeredUser
                                    
                                    // initialize view controller
                                    let viewObject = self.storyboard?.instantiateViewController(withIdentifier: "scheduleView") as! ScheduleViewController // prepare view controller object
                                    self.navigationController?.pushViewController(viewObject, animated: true) // present schedule view controller
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateSchedule() {
        let scheduleId = Global.user?.student?.schedule?.id
        let studentId = Global.user?.student?.id
        let url = "\(Global.apiRoot)/schedules/\(scheduleId!)/"
        scheduleParams["student"] = studentId!
        Alamofire.request(url, method: .put, parameters: scheduleParams, encoding: JSONEncoding.default).responseJSON { response in // use Alamofire request to modify user's schedule using PUT request
            print(response.response?.statusCode)
            if response.result.isSuccess && response.response?.statusCode == 200 {
                let newScheduleData = response.result.value as! NSDictionary
                let newSchedule = Schedule(data: newScheduleData)
                Global.user?.student?.schedule = newSchedule
                let viewObject = self.storyboard?.instantiateViewController(withIdentifier: "scheduleView") as! ScheduleViewController // prepare view controller object
                self.navigationController?.pushViewController(viewObject, animated: true) // present schedule view controller
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyboard()
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
