//
//  EnterScheduleViewController.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-04-10.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import UIKit

class EnterScheduleViewController: UIViewController {
    
    var registeredUser : User!
    var params : [String : String] = [:]
    var timesPressed = 0 // variable counting how many times the next button is pressed to know when the user has entered all of their schedule data
    
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
        self.navigationItem.setHidesBackButton(true, animated : true)
        // Do any additional setup after loading the view.
        nextButton.layer.cornerRadius = 15
        // setup params dictionary
        for i in 1 ... 2 {
            for j in 1 ... 4 {
                params["d\(i)p\(j)"] = ""
            }
        }
    }

    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func nextPressed(_ sender: UIButton) {
        if (p1Field.text != nil && p2Field.text != nil && p3Field.text != nil && p4Field.text != nil) {
            if (timesPressed == 0) {
                // update the view
                timesPressed += 1
                p1Field.placeholder = "Day 2 Period 1 Class"
                p2Field.placeholder = "Day 2 Period 2 Class"
                p3Field.placeholder = "Day 2 Period 3 Class"
                p4Field.placeholder = "Day 2 Period 4 Class"
                nextButton.setTitle("Finish", for: .normal)
                
                // update params dictionary with new data
                
            } else {
                // make Alamofire calls to add schedule data and show schedule view controller
                
                // update params dictionary
            }
        }
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
