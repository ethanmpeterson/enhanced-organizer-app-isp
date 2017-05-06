//
//  SettingsViewController.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-05-06.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var saveDataSwitch: UISwitch!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var changeScheduleButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController!.navigationBar.barTintColor = UIColor(red: 190.0 / 255, green: 25.0 / 255, blue: 46.0 / 255, alpha: 100.0 / 100.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        saveLabel.layer.cornerRadius = 25
        changeScheduleButton.layer.cornerRadius = 25
        logOutButton.layer.cornerRadius = 25
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let offlineMode = Global.isOfflineMode() {
            saveDataSwitch.isOn = offlineMode
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func switched(_ sender: UISwitch) { // runs when value has changed on switch for whether to save account data locally or not
        if (saveDataSwitch.isOn) {
            Global.saveData((Global.user?.encoded())!, "userData")
            Global.saveData((Global.user?.student?.encoded())!, "studentData")
            Global.saveData((Global.user?.student?.schedule?.encoded())!, "scheduleData")
            UserDefaults.standard.set(true, forKey: "offlineMode")
        } else {
            UserDefaults.standard.set(false, forKey: "offlineMode")
        }
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func changeSchedulePressed(_ sender: UIButton) {
        let viewObject = self.storyboard?.instantiateViewController(withIdentifier: "enterSchedule") as! EnterScheduleViewController // prepare view controller object
        viewObject.fromSettings = true
        self.navigationController?.pushViewController(viewObject, animated: true) // present schedule view controller
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
