//
//  ScheduleViewController.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-03-21.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import UIKit
import Alamofire

class ScheduleViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dateDisplay: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        // Do any additional setup after loading the view.
        dateDisplay.delegate = self
    }

    // TEXT FIELD AND DATEPICKER CODE:
    
    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePicker = UIDatePicker()
        textField.inputView = datePicker
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(ScheduleViewController.datePickerChanged(_:)), for: .valueChanged)
    }
    
    func datePickerChanged(_ sender: UIDatePicker) { // runs when the user selects a new date in the DatePicker
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dateDisplay.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyboard()
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
