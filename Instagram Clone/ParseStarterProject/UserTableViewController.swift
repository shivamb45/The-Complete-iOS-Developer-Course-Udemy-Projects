//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Shivam Bharadwaj on 27/06/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class UserTableViewController: UITableViewController {
    
    var usernames = [""]
    var userIds = [""]
    var isFollowig = ["user" : false]
    var refresher : UIRefreshControl!
    
    @IBAction func logout(_ sender: Any) {
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x:0,y:0,width:50,height:50))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        UIApplication.shared.beginIgnoringInteractionEvents()
        PFUser.logOut()
        UIApplication.shared.endIgnoringInteractionEvents()
        activityIndicator.stopAnimating()
        performSegue(withIdentifier: "showHomeAfterLogout", sender: self)
    }
    
    
    
    func getData(){
        
        let query = PFUser.query()
        query?.findObjectsInBackground(block: { (objectsArray, error) in
            if error != nil {
                print ("Error occured for query")
                
            }
            else if let users = objectsArray {
                
                self.usernames.removeAll()
                self.userIds.removeAll()
                for user in users{
                    if let u = user as? PFUser
                    {
                        var firstName = u.username!.components(separatedBy: "@")
                        self.usernames.append(firstName[0])
                        self.userIds.append(u.objectId!)
                        
                        let query = PFQuery(className: "Followers")
                        query.whereKey("follower", equalTo: PFUser.current()?.objectId!)
                        query.whereKey("following", equalTo: u.objectId!)
                        query.findObjectsInBackground(block: { (objects, error) in
                            if let objectArray =  objects {
                                if objectArray.count > 0 {
                                    self.isFollowig[u.objectId!] = true
                                    print(self.isFollowig)
                                }
                                else{
                                    self.isFollowig[u.objectId!] = false
                                    print(self.isFollowig)
                                }
                                if self.isFollowig.count == self.usernames.count {
                                    self.tableView.reloadData()
                                }
                                self.refresher.endRefreshing()
                            }
                        })
                    }
                }
            }
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
      getData()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refresher.addTarget(self, action: #selector(UserTableViewController.getData), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresher)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
         cell.textLabel?.text = usernames[indexPath.row]
        if isFollowig[userIds[indexPath.row]] != nil {
            if isFollowig[userIds[indexPath.row]]! {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
        }
        else{
            print("FOund a NIL for \(userIds[indexPath.row]) which is for \(usernames[indexPath.row])")
        }
     
        return cell
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if isFollowig[userIds[indexPath.row]] != nil{
            if isFollowig[userIds[indexPath.row]]! {
                //code to unfollow the selected user
                
                cell?.accessoryType = UITableViewCellAccessoryType.none
                let query = PFQuery(className: "Followers")
                query.whereKey("follower", equalTo: (PFUser.current()?.objectId!))
                query.whereKey("following", equalTo: userIds[indexPath.row])
                
                query.findObjectsInBackground(block: { (objects, error) in
                    if let objectsArray = objects {
                        for object in objectsArray {
                            object.deleteInBackground()
                            
                        }
                    }
                })
                isFollowig[userIds[indexPath.row]] = false
            }
            else{
                
                cell?.accessoryType = UITableViewCellAccessoryType.checkmark
                let following = PFObject(className: "Followers")
                following["follower"] = PFUser.current()?.objectId
                following["following"] = userIds[indexPath.row]
                following.saveInBackground()
            }
            
            
        }
        else{
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
            let following = PFObject(className: "Followers")
            following["follower"] = PFUser.current()?.objectId
            following["following"] = userIds[indexPath.row]
            following.saveInBackground()
            isFollowig[userIds[indexPath.row]] = true
        }
        
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
