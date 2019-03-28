//
//  Item.swift
//  Homepwner
//
//  Created by Peter on 08/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import Foundation
import UIKit

class Item: NSObject, NSCoding
{
    
    // MARK: - Encoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(itemKey, forKey: "itemKey")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
    }
    
    // MARK: - Decoding
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        itemKey = aDecoder.decodeObject(forKey: "itemKey") as! String
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as! String?
        valueInDollars = aDecoder.decodeInteger(forKey: "valueInDollars")
        
        super.init()
    }
    
    // MARK: - Stored Properities
    
    var name : String
    var valueInDollars : Int
    var serialNumber : String?
    var dateCreated: Date
    let itemKey: String
    
    //MARK: - Initialisers
    
    init(name: String, value: Int, serialNumber : String?){
        //ensure that all properities in the class have value
        self.name = name
        self.valueInDollars = value
        self.serialNumber = serialNumber
        dateCreated = Date()
        self.itemKey = UUID().uuidString
        
        //call designated initialiser up the inehritance chain
        super.init()
    }
    
    convenience init(random: Bool){
        if random{
            let adjectives = ["Fluffy","Rusty","Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var indx = adjectives.count.arc4_random
            let randomAdjective = adjectives[indx]
            
            indx = nouns.count.arc4_random
            let randomNoun = nouns[indx]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = 100.arc4_random
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName, value: randomValue, serialNumber: randomSerialNumber)
        }else{
            self.init(name: "", value: 0, serialNumber: nil)
        }
    }
    
}

//MARK: - Integer extension

extension Int{
    var arc4_random: Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(self)))
        }else {
            return 0
        }
    }
}
