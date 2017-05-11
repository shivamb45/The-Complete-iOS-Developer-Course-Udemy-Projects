//
//  ViewController.swift
//  Cat Years
//
//  Created by Shivam Bharadwaj on 11/05/17.
//  Copyright © 2017 Shivam Bharadwaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var HumanAgeEntered: UITextField!
    @IBOutlet weak var catAgeCalculated: UILabel!
    
    @IBAction func calculateBtn(_ sender: Any) {
        print(HumanAgeEntered.text!)
        let hageint = Int(HumanAgeEntered.text!)
        let catage = hageint! * 7
        catAgeCalculated.text = String(catage)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

