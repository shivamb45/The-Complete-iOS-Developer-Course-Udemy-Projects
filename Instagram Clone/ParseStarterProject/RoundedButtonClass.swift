//
//  RoundedButtonClass.swift
//  ParseStarterProject-Swift
//
//  Created by Shivam Bharadwaj on 26/06/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

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
