//
//  ViewController.swift
//  Downloading Images
//
//  Created by Shivam Bharadwaj on 26/06/17.
//  Copyright © 2017 Shivam Bharadwaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string:"https://avatars2.githubusercontent.com/u/17218616?v=3&s=400")
        let request = NSMutableURLRequest(url: url!)
//        let task = URLSession.shared.dataTask(with: url!){
//            data,response,error in
//            if error != nil {
//                print("Error ")
//                print(error)
//            }
//            else {
//                let img = UIImage(data: data!)
//                self.webImage.image = img
//                print("image setted") 
//            }
//        }
        
        //code to fetch and save image to documents directory
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,response,error) in
            if error != nil {
                                print("Error ")
                                print(error)
                            }
                            else {
                                let img = UIImage(data: data!)
                                self.webImage.image = img
                                print("image setted")
                                let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                print(documentPath)
                let savePath = documentPath[0] as! String + "/fetchImage.jpg"
                do{
                try UIImageJPEGRepresentation(img!, 1)?.write(to: URL(fileURLWithPath: savePath))
                    print("Image Saved")
                }
                catch{
                    print("Cannot save Image")
                }
                            }})
        task.resume()
        
        //code to restore the Image from saved location
//        let originalPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let restoreImgPath = originalPath[0] as! String + "/fetchImage.jpg"
//        webImage.image = UIImage(contentsOfFile: restoreImgPath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

