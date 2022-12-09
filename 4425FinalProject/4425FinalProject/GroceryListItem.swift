//
//  GroceryListItem.swift
//  4425FinalProject
//
//  Created by Hailey Jessee & Jack Stepanek on 11/28/22.
//

import SwiftUI

struct GroceryListItem: View {
    let dateFormatter = DateFormatter()
    var item: Item
    
    init(item: Item) {
        self.item = item
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
    }
    
    var body: some View {
        VStack {
            HStack { Text(item.groceryitem ?? "Missing Title").font(.system(size: 14))
                Spacer() }
            
            HStack { Text("Needed By: " + dateFormatter.string(from: item.neededby ?? Date())).font(.system(size: 10))
                Spacer() }
        }
    }
}

struct GroceryListItem_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListItem(item: GroceryListProvider().item)
    }
}

struct GroceryListProvider {
    var item = Item(context: PersistenceController.preview.container.viewContext)
    init() {
        item.groceryitem = "Grocery Item"
        item.amount = 1
        item.neededby = Date()
        item.highPriority = true
        item.completedOn = nil
    }
    
}

