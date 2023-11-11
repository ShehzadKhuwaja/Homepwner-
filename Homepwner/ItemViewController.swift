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
        // Get the status bar height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        // Create a UIImageView with your background image
        let backgroundImage = UIImageView(image: UIImage(named: "cat"))
        backgroundImage.contentMode = .scaleAspectFill

        // Set the background view of the UITableView
        tableView.backgroundView = backgroundImage
        
        // Add any other configuration code for your UITableView
        // ...

        // Reload the data if needed
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else {
            let dataSourceCount = itemStore.allItems.filter {
                $0.valueInDollars > 50
            }.count
            
            if indexPath.row < dataSourceCount {
                return 60
            }
            else {
                return 44
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Items Worth more than $50"
        } else {
            return "Other Items"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // section numbering starts from 0
        if section == 0 {
            // return the count for cells with price > 50
            // itemStore.allItems.filter returns an filtered array
            // use .count on filtered array to get total elements
            
            return itemStore.allItems.filter {
                $0.valueInDollars > 50
            }.count
            
        } else {
            // return the count for cells with price <= 50
            return itemStore.allItems.filter {
                $0.valueInDollars <= 50
            }.count + 1
        }
        
        // return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        var item: Item!
        
        if indexPath.section == 0 {
            let highPriceItems = itemStore.allItems.filter {
                $0.valueInDollars > 50
            }
            item = highPriceItems[indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            return cell
        } else {
            let lowPriceItems = itemStore.allItems.filter {
                $0.valueInDollars <= 50
            }
            if indexPath.row < lowPriceItems.count {
                item = lowPriceItems[indexPath.row]
                cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
                cell.textLabel?.text = item.name
                cell.detailTextLabel?.text = "$\(item.valueInDollars)"
                return cell
            } else {
                cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
                cell.textLabel?.text = "No more Items"
                cell.detailTextLabel?.text = ""
                return cell
            }
        }
        
        // Set the text on the cell with the description of the item
        // that is at the nth number of items, where n = row this cell
        // will appear in on the table view
        //let item = itemStore.allItems[indexPath.row]
        //cell.textLabel?.text = item.name
        //cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        //return cell
        
        
    }
}
