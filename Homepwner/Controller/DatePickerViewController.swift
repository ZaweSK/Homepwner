//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by Peter on 15/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    // MARK: - Stored Properities
    
    var item: Item! {
        didSet{
            navigationItem.title = "\(item.name) creation date"
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        datePicker.datePickerMode = .date
        datePicker.date = item.dateCreated
    }

    // MARK: - @IBActions & @IBOutlets
    
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
