//
//  ItemViewController.swift
//  Homepwner
//
//  Created by MindMingle on 10/11/2023.
//

import UIKit

class ItemViewController: UITableViewController {
    
    var itemStore: ItemStore = ItemStore()
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemStore.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == itemStore.allItems.count {
            return sourceIndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        
        // Set the text on the cell with the description of the item
        // that is at the nth number of items, where n = row this cell
        // will appear in on the table view
        
        if indexPath.row < itemStore.allItems.count {
            let item = itemStore.allItems[indexPath.row]
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            
            // setting text color for value label based on its value in $
            if item.valueInDollars < 50 {
                cell.valueLabel.textColor = .green
            } else {
                cell.valueLabel.textColor = .red
            }
            
            cell.valueLabel.text = "$\(item.valueInDollars)"
            return cell
        } else {
            cell.nameLabel.text = "No More Items"
            cell.serialNumberLabel.text = ""
            cell.valueLabel.text = ""
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        // this method changes title for delete button which shows up in edit mode when you click the minus button
        return "Remove"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // if the table view is asking to commit a delete command
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                // Remove the item from the item store
                self.itemStore.removeItem(item)
                
                // Also remove the row from the tableview with animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where that item is in array
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showItem"?:
            // Figure out which row was tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            preconditionFailure("Unexpected Segue Identifier.")
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
}
