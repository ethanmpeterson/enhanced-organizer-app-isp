//
//  RegisterViewController.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-03-24.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController!.navigationBar.barTintColor = UIColor(red: 190.0 / 255, green: 25.0 / 255, blue: 46.0 / 255, alpha: 100.0 / 100.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        continueButton.layer.cornerRadius = 15
        backToLoginButton.layer.cornerRadius = 15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
