//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Peter on 08/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {

    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    // MARK: - @IBOutlets & @IBActions
    @IBAction func addNewItem(_ sender: UIBarButtonItem){
        let newItem = itemStore.createItem()
        if let index = itemStore.allItems.index(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source & delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    //    private func isLastRow(_ indexPath: IndexPath) -> Bool{
    //        return indexPath.row == itemStore.allItems.count
    //    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        
        let itemCell = cell as! ItemCell
        let item = itemStore.allItems[indexPath.row]
        itemCell.nameLabel.text = item.name
        itemCell.valueLabel.text = "$\(item.valueInDollars)"
        itemCell.serialNumberLabel.text = item.serialNumber
        itemCell.setValueColor()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                self.itemStore.removeItem(item)
                
                self.imageStore.deleteImage(forKey: item.itemKey)
                
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
//    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return (tableView.cellForRow(at: indexPath))?.reuseIdentifier == "NoMoreItemsCell" ? .none : .delete
//    }
//
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return (tableView.cellForRow(at: indexPath))?.reuseIdentifier == "NoMoreItemsCell" ? false : true
//    }
    
//    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
//        if proposedDestinationIndexPath.row == itemStore.allItems.count  {
//            return IndexPath(row: proposedDestinationIndexPath.row - 1, section: 0)
//        }else{
//            return proposedDestinationIndexPath
//        }
//    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItem"{
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailVC = segue.destination as! DetailViewController
                detailVC.item = item
                detailVC.imageStore = imageStore
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
