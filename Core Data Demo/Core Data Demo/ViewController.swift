//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Shivam Bharadwaj on 25/06/17.
//  Copyright © 2017 Shivam Bharadwaj. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //coredata accessing helpers
        let appdelegate = UIApplication.shared.delegate as! AppDelegate //points to appdelegate.swift file
        let context = appdelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserDetails", into: context)
        newUser.setValue("Shabana AAzmi", forKey: "username")
        newUser.setValue("password", forKey: "password")
        newUser.setValue(11,forKey: "age")
        do{
            try context.save()
            print("Trial Succeeded")
        }
            catch{
                print("I have Failed you master")
            }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDetails")
        request.returnsObjectsAsFaults = false
        do{
            let resultSet = try context.fetch(request)
            if resultSet.count > 0 {
                for r in resultSet as! [NSManagedObject] {
                    if let uname = r.value(forKey: "username") as? String {
                        print(" Name is \(uname)")
                    }
                }
            }
            else{
                print("No Resukts")
            }
        }
        catch{
            print("I have failed you for returning the request")
        }
//        NSPredicate Added
        
//        request.predicate = NSPredicate(format: "age < %d", 10)
        request.predicate = NSPredicate(format: "username == %@", "Shabana")
        do{
            let resultSet = try context.fetch(request)
            if resultSet.count > 0 {
                for r in resultSet as! [NSManagedObject] {
                    if let uname = r.value(forKey: "username") as? String {
                        print("Previous Name is \(uname)")
                        r.setValue("Shabana", forKey: "username") //Changing Values
                        do{
                            try context.save()
                            print("saved!")
                        }
                        catch{
                            print("Couldn't save")
                        }
                        print(r)
                    }
                }
            }
            else{
                print("No Resukts")
            }
            print(resultSet)
        }
        catch{
            print("I have failed you for returning the request")
        }
        
        //NSPredicate Deleting the searched results
        do{
            let resultSet = try context.fetch(request)
            if resultSet.count > 0 {
                for r in resultSet as! [NSManagedObject]{
                    if let uname = r.value(forKey: "username") as? String{
                        print("following data is to be deleted \(uname)")
                        context.delete(r)
                        do {
                            try context.save()
                        }
                        catch{
                            print("cannot Save")
                        }
                    }
                }
            }
        }
        catch{
            print("Cannot fetch!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

