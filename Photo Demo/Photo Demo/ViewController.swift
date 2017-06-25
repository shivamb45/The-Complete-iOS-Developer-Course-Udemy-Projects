//
//  ViewController.swift
//  Photo Demo
//
//  Created by Shivam Bharadwaj on 25/06/17.
//  Copyright © 2017 Shivam Bharadwaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageCanvas.image = img
            
        }
        else {
            print("Image Not FOUND SOME ERROR! ")
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var imageCanvas: UIImageView!
    @IBAction func importPhoto(_ sender: Any) {
        let imagepickercontroller = UIImagePickerController()
        imagepickercontroller.delegate = self
        imagepickercontroller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagepickercontroller.allowsEditing = false
        self.present(imagepickercontroller,animated: true,completion: nil)
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

