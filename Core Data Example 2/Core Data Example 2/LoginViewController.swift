//
//  LoginViewController.swift
//  Core Data Example 2
//
//  Created by Shivam Bharadwaj on 26/06/17.
//  Copyright © 2017 Shivam Bharadwaj. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordEntered: UITextField!
    @IBOutlet weak var usernameEntered: UITextField!
    @IBAction func LoginAttempt(_ sender: Any) {
        print("Login Attempt started")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let user = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        let requestAllUsers = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        requestAllUsers.returnsObjectsAsFaults = false
        do{
            let resultSet = try context.fetch(requestAllUsers)
            if resultSet.count > 0 {
                // code to compare each username with given one and then switch to next card
            }
            else{
              // else show the other msg
            }
        }
        catch {
            print("Some Error Occurred")
        }
        
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
