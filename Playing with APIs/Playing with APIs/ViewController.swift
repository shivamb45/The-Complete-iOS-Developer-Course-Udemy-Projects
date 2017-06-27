//
//  ViewController.swift
//  Playing with APIs
//
//  Created by Shivam Bharadwaj on 26/06/17.
//  Copyright © 2017 Shivam Bharadwaj. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let apiURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=delhi&APPID=1699f991da059337e67157e0c2a490d6")
        let session = URLSession.shared
        let task = session.dataTask(with: apiURL as! URL, completionHandler: {(data,response,error) in
            if error != nil {
                print("Error")
                print(error)
                
            }
            else{
                if let userData = data {
                do{
                   let jsonResult = try JSONSerialization.jsonObject(with: userData, options: JSONSerialization.ReadingOptions.mutableContainers)
                    print(jsonResult)
//                    print(jsonResult["name"])
                    
                    if let dictionary = jsonResult as? [String: Any] {
                        if let number = dictionary["name"] as? String {
                            // access individual value in dictionary
                            print(number)
                        }
                        
//                        for (key, value) in dictionary {
//                            // access all key / value pairs in dictionary
//                        }
                        
                        if let nestedDictionary = dictionary["weather"] as? [String: Any] {
                            // access nested dictionary values by key
                            print(nestedDictionary)
                        }
                    }

                   
                }
                catch{
                    print("Cannot Print JSON Result")
                }
                }
            }
        })
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

