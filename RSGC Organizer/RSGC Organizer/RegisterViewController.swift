//
//  RegisterViewController.swift
//  RSGC Organizer
//
//  Created by Ethan Peterson on 2017-03-24.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var reTypePasswordField: UITextField!
    
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

    @IBAction func continuePressed(_ sender: UIButton) {
        if (userField.text != "" && emailField.text != "" && passwordField.text != "" && reTypePasswordField.text != "") {
            if (passwordField.text == reTypePasswordField.text) {
                let params : [String : Any] = [
                    "username" : userField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
                    "email" : emailField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
                    "password" : passwordField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                ]
                // post Data to backend
                Alamofire.request("http://127.0.0.1:8000/register/", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
                    if response.result.isSuccess {
                        if (response.response?.statusCode == 400) { // http code 400 is for bad request my backend returns this when bad data is given like username that is already used by another account
                            let alert = UIAlertController(title: "Error", message: "Username / E-mail is already linked to another account.", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        } else if (response.response?.statusCode == 201) { // http 201 means the user has been created and we can initialize the user object on the front end
                            
                        } else { // handle other errors
                            let alert = UIAlertController(title: "Error", message: "Unkown server error", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        }
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Server Error", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Password entries are not the same.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            // show dialog box telling user to complete all fields
            let alert = UIAlertController(title: "Error", message: "Please complete all fields.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
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
