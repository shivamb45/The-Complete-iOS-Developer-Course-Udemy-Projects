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
    
    @IBOutlet weak var SignUpOrLoginButton: UIButton!
    @IBOutlet weak var toggleSignUpLoginButton: UIButton!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func SignUpOrLogin(_ sender: Any) {
        if emailTextField.text == "" || passwordField.text == "" {
           //code to show an alert to user.
            createInfoAlert(title: "Oops", msg: "Please fill all the fields")
            print("Sign up Button Pressed")
        }
        else{
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x:0,y:0,width:100,height:100))
            activityIndicator.hidesWhenStopped = true
            activityIndicator.center = view.center
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            print("Not in IF Segment")
            if signUpMode {
                // fn SignUP Mode on dude
                
                let user = PFUser()
                user.username = emailTextField.text
                user.password = passwordField.text
                user.email = emailTextField.text
                
                user.signUpInBackground(block: { (bool, error) in
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.activityIndicator.stopAnimating()
                    if error != nil {
                        print("Error Encountererd while signing up ")
                        print(error!)
                        var displayerrorMsg = "Something went wrong. Please try again later or report the developer"
//                        if let errorMsg = error?.UserInfo["error"] as? String {
//                            displayerrorMsg = errorMsg
//                        }
//                        In Swift 3 NSError has been replaced in many API with more generic Swift Error protocol which has no userInfo dictionary. Bridge cast the object to NSError
                        if let errorMsg = (error! as NSError).userInfo["error"] as? String {
                            displayerrorMsg = errorMsg
                        }
                        self.createInfoAlert(title: "Ooops", msg: displayerrorMsg)
                    }
                    else{
                        if bool == true {
//                            self.createInfoAlert(title: "Congrats!", msg: "You have been successfully signedup to Instagram clone")
////                            solution as Per
////                            https://stackoverflow.com/questions/32292600/swift-performseguewithidentifier-not-working
//                            OperationQueue.main.addOperation {
//                                [weak self] in
//                                self?.performSegue(withIdentifier: "showUserList", sender: self)
//                            }
//                            self.performSegue(withIdentifier: "showUserList", sender: self)
                            
                            //code for showing next user list only when pressed ok and notified of successfull signup
                            
                            let showInfo = UIAlertController(title: "Congrats! ", message: "you have been successfully signed up. click OK to continue", preferredStyle: UIAlertControllerStyle.alert)
                            showInfo.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                                self.dismiss(animated: true, completion:nil)
                                                            OperationQueue.main.addOperation {
                                                                [weak self] in
                                                                self?.performSegue(withIdentifier: "showUserList", sender: self)
                                                            }
                                                            //self.performSegue(withIdentifier: "showUserList", sender: self)
                                
                            }))
                            self.present(showInfo,animated: true,completion: nil)
                        }
                    }
                })
            }
            else{
                // The Login mode
                
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordField.text!, block: { (user, error) in
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    if error != nil {
                        var displayerrorMsg = "Something went wrong. Please try again later or report the developer"
                        if let errorMsg = (error! as NSError).userInfo["error"] as? String {
                            displayerrorMsg = errorMsg
                        }
                        self.createInfoAlert(title: "Uff!", msg: displayerrorMsg)
                    }
                    else{
                        self.createInfoAlert(title: "👍", msg: "Login Successfull !")
//                        solution as per
//                        https://stackoverflow.com/questions/32292600/swift-performseguewithidentifier-not-working
                        OperationQueue.main.addOperation {
                            [weak self] in
                            self?.performSegue(withIdentifier: "showUserList", sender: self)
                        }
                    }
                })
            }
        }
    }
    
    func createInfoAlert(title: String,msg: String){
        let warning = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        warning.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion:nil)
        }))
        self.present(warning,animated: true,completion: nil)
    }
    @IBAction func toggleSignUpLogin(_ sender: Any) {
        if signUpMode {
            //change to the login mode
            SignUpOrLoginButton.setTitle("Login", for: [])
            toggleSignUpLoginButton.setTitle("Sign Up", for: [])
            msg.text = "Don't have an account?"
            signUpMode = false
            print("Pressed toggle Button")
        }
        else{
            SignUpOrLoginButton.setTitle("Sign Up", for: [])
            toggleSignUpLoginButton.setTitle("Login", for: [])
            msg.text = "Already a member?"
            signUpMode = true
            print("Oressed toggle Button")
        }
    }
    @IBOutlet weak var msg: UILabel!
    
    var signUpMode = true
    var activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
//    Following Code Snippet is from stackoverflow https://stackoverflow.com/questions/38874517/how-to-make-a-simple-rounded-button-in-storyboard
    
    @IBDesignable class RoundedButtonClass: UIButton
    {
        override func layoutSubviews() {
            super.layoutSubviews()
            
            updateCornerRadius()
        }
        
        @IBInspectable var rounded: Bool = false {
            didSet {
                updateCornerRadius()
            }
        }
        
        func updateCornerRadius() {
            layer.cornerRadius = rounded ? frame.size.height / 2 : 0
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if PFUser.current() != nil {
            performSegue(withIdentifier: "showUserList", sender: self)
            
        }
        navigationController?.navigationBar.isHidden = true
    }
}
