//
//  GroceryView.swift
//  4425FinalProject
//
//  Created by Hailey Jessee & Jack Stepanek on 11/28/22.
//

import SwiftUI

struct GroceryView: View {
    let dateFormatter = DateFormatter()
    var item: Item
    
    init(item: Item) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        self.item = item
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(spacing: 5) {
                    HStack {
                        Text("Item:").foregroundColor(Color.gray).font(.system(size: 12))
                        Text(item.groceryitem ?? "Missing Title")
                        Spacer()
                    }
                    HStack {
                        Text("High priority:").foregroundColor(Color.gray).font(.system(size: 12))
                        if (item.highPriority) {
                            Text("Yes!").font(.system(size: 14))
                        } else {
                            Text("No!").font(.system(size: 14))
                        }
                        Spacer()
                    }
                    HStack {
                        Text("Created:").foregroundColor(Color.gray).font(.system(size: 12))
                        if let createdOn = item.createdOn {
                            Text(dateFormatter.string(from: createdOn)).font(.system(size: 14))
                        } else {
                            Text("Date Missing").font(.system(size: 14))
                        }
                        Spacer()
                    }
                    HStack {
                        Text("Completed:").foregroundColor(Color.gray).font(.system(size: 12))
                        if let completedOn = item.completedOn {
                            Text(dateFormatter.string(from: completedOn)).font(.system(size: 14))
                        } else {
                            Text("Not Completed").font(.system(size: 14))
                        }
                        Spacer()
                    }
                    HStack {
                        Text("Brand:").foregroundColor(Color.gray).font(.system(size: 12))
                        Spacer()
                    }
                }
                Spacer()
            }.padding()
            Spacer()
        }.navigationTitle("Grocery List")
    }

}

struct GroceryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GroceryView(item: GroceryViewItemProvider().item)
                .previewInterfaceOrientation(.portrait)
        }
    }
}

struct GroceryViewItemProvider {
    var item = Item(context: PersistenceController.preview.container.viewContext)
    init() {
        item.groceryitem = "Grocery Item"
        item.createdOn = Date()
        item.highPriority = true
        item.completedOn = nil
    }
    
}


