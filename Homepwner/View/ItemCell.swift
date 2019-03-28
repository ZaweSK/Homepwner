//
//  ItemCell.swift
//  Homepwner
//
//  Created by Peter on 14/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        
        
    }
    
    func setValueColor(){
        let value = valueLabel.text!.value
        valueLabel.textColor = value > 50 ? UIColor.red : UIColor.green
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
}

extension String{
    var value: Int {
        var textValue = self
        textValue.remove(at: textValue.startIndex)
        if let valueInt = Int(textValue){
            return valueInt
        }else {
            return 0
        }
    }
}
