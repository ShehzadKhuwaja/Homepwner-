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
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
}
