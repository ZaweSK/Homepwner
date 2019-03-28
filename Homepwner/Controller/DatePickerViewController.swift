//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by Peter on 15/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    var item: Item! {
        didSet{
            navigationItem.title = "\(item.name) creation date"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        datePicker.datePickerMode = .date
        datePicker.date = item.dateCreated
    }

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        item.dateCreated = datePicker.date
        
        let alert = UIAlertController(title: "Date was saved", message: nil, preferredStyle: .alert )
        let action = UIAlertAction(title: "OK", style: .default,
                                   handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
