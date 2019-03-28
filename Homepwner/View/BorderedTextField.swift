//
//  BorderedTextField.swift
//  Homepwner
//
//  Created by Peter on 15/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class BorderedTextField: UITextField {

    override func becomeFirstResponder() -> Bool {
        layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 5.0
        
        super.becomeFirstResponder()
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        super.resignFirstResponder()
        return true
    }

}
