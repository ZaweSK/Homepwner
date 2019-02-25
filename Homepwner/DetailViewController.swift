//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Peter on 14/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - @IBOutlets & @IBActions
    @IBOutlet var nameField: BorderedTextField!
    @IBOutlet var serialNumberField: BorderedTextField!
    @IBOutlet var valueField: BorderedTextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var trashButton: UIBarButtonItem!
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    // MARK: - Properties
    var item: Item! {
        didSet{
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    
    
    // MARK: - Formatters
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
    
    // MARK: - UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDatePicker"{
            if let datePickerCV = segue.destination as? DatePickerViewController{
                datePickerCV.item = item
            }
        }
    }
    
    // MARK: - Life cycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        let key  = item.itemKey
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
        
        updateTrashButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        }else{
            item.valueInDollars = 0
        }
    }
    
    
    // MARK: - Image Handling
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        //cache the image
        imageStore.setImage(image, forKey: item.itemKey)
        
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func updateTrashButton(){
        trashButton.isEnabled = imageView.image != nil ? true : false
    }
    
    @IBAction func trashButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Are you sure you want to delete the picture?", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.imageStore.deleteImage(forKey: self.item.itemKey)
            self.imageView.image = nil
            self.updateTrashButton()
        }
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
