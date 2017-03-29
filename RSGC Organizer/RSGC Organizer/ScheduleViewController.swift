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
    @IBOutlet weak var dayDisplay: UILabel!
    @IBOutlet weak var p1: UILabel!
    @IBOutlet weak var p2: UILabel!
    @IBOutlet weak var p3: UILabel!
    @IBOutlet weak var p4: UILabel!
    @IBOutlet weak var todayButton: UIButton!
    
    var dateChanged : Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // style various aspects of the view controller before it is shown
        p1.layer.cornerRadius = 20
        p2.layer.cornerRadius = 20
        p3.layer.cornerRadius = 20
        p4.layer.cornerRadius = 20
        todayButton.layer.cornerRadius = 15
        
        // Style Navigation Bar
        navigationController!.navigationBar.barTintColor = UIColor(red: 28.0 / 255, green: 63.0 / 255, blue: 148.0 / 255, alpha: 100.0 / 100.0) // set navigation bar to RSGC blue color
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] // Make title text white
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    func updateScheduleDisplay(_ dayNum : Int, _ dateString : String) { // function updates schedule display taking the desired dayNumber and a date string to show in the date textbox
        Global.user?.student?.schedule?.update(dayNum)
        // show schedule Data
        p1.text = Global.user?.student?.schedule?.p1
        p2.text = Global.user?.student?.schedule?.p2
        p3.text = Global.user?.student?.schedule?.p3
        p4.text = Global.user?.student?.schedule?.p4
        dateDisplay.text = dateString
        
        // handle when the today button is shown
        if (dateChanged) { // only show today button when the user has changed the date
            todayButton.layer.isHidden = false
        } else {
            todayButton.layer.isHidden = true
        }
        
        // handle the text box showing the day making sure the raw daynumber is not shown when it is a holiday / special event (day 9 and 0)
        if (dayNum == 9) {
            dayDisplay.text = "Day: H"
        } else if (dayNum == 0) {
            dayDisplay.text = "Day: S"
        } else {
            dayDisplay.text = "Day: \(dayNum)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated : true)
        // Do any additional setup after loading the view.
        dateDisplay.delegate = self
        let currentDate = NSDate()
        updateScheduleDisplay(Global.dayNum(), Global.dateString(currentDate))
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
        dateChanged = true
        let formatter = DateFormatter()
        let cal = Calendar.current
        let month = (cal as NSCalendar).component(.month, from: sender.date)
        let day = (cal as NSCalendar).component(.day, from: sender.date)
        let changedDayNum = Global.scheduleArray[month - 1][day]
        formatter.dateStyle = .long
        dateDisplay.text = formatter.string(from: sender.date)
        updateScheduleDisplay(changedDayNum, Global.dateString(sender.date as NSDate))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dateDisplay.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyboard()
    }
    
    // BUTTON FUNCTIONS
    
    @IBAction func todayPressed(_ sender: UIButton) { // runs when today button is pressed
        dateChanged = false
        let date = NSDate()
        updateScheduleDisplay(Global.dayNum(), Global.dateString(date))
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
