//
//  ItemStore.swift
//  Homepwner
//
//  Created by MindMingle on 10/11/2023.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        // The @discardableResult annotation means that a caller of this function is free to ignore the result of calling this function.
        
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to the object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        // Remove item from the array
        allItems.remove(at: fromIndex)
        
        // Insert Item in array in the new position
        allItems.insert(movedItem, at: toIndex)
    }
}
