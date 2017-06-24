/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let testObject = PFObject(className: "UserDetails")
//        
//        testObject["name"] = "Shivam"
//        
//        testObject.saveInBackground { (success, error) -> Void in
//            
//            // added test for success 11th July 2016
//            
//            if success {
//                
//                print("Shivam has been saved.")
//                
//            } else {
//                
//                if error != nil {
//                    
//                    print (error)
//                    
//                } else {
//                    
//                    print ("Error")
//                }
//                
//            }
//            
//        }
        let query = PFQuery(className: "UserDetails")
        query.getObjectInBackground(withId: "dbE3cRFC5e") {
            (object,error) in
            if error != nil
            {
                print(error!)
            }
            else{
                if let user = object {
                    print("Retrived data")
                    print(user)
                    
                    user["name"] = "SHIVAM"
                    user.saveInBackground(block: {
                    (success,error) in
                        if success {
                            print("Value altered for sure")
                        }
                    else
                        {
                            print("Value alteration failed")
                        }})
                }
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
