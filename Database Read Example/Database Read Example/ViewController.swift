//
//  ViewController.swift
//  Database Read Example
//
//  Created by Ethan Peterson on 2017-03-06.
//  Copyright © 2017 Ethan Peterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string : "https://ethanpeterson.tech/service.php") // initialize URL class with url to the php script on my server that will encode my database table as JSON in an array of dictionaries
        let task = URLSession.shared.dataTask(with: url!) { (rawData, response, error) in // initialize URL task to prepare to collect the data
            if (error != nil) { // check if the initialization of the data task encountered an error and print it
                print(error as Any)
            } else { // if there is no error than continue with JSON parsing
                if let data = rawData { // safely unwrap json data variable provided by data task
                    do { // safely attempt to initialize the data as a JSON object
                        let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject // cast JSON object to AnyObject
                        print(json) // print the json file after its collected
                    } catch { // run this code if the JSON serialization fails and throws and error
                        // catch an error
                        print("error")
                    }
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

