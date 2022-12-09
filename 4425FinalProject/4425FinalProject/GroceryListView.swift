//
//  GroceryListView.swift
//  4425FinalProject
//
//  Created by Hailey Jessee & Jack Stepanek on 11/28/22.
//

import SwiftUI

enum ItemError: Error {
  case deleteError
}

struct GroceryListView: View {
    let dateFormatter = DateFormatter()
    
    @State var showingNewItemPopover = false
    @State var showingDeleteItemErrorAlert = false
    @State var deleteItemErrorMessage = ""
    
    init() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
    }
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.groceryitem, ascending: true)], animation: .default) private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: GroceryView(item: item)) {
                        GroceryListItem(item: item)
                    }
                }.onDelete(perform: deleteItems)
            }.alert(isPresented: $showingDeleteItemErrorAlert) {
                Alert(title: Text("Error Deleting Item"),
                      message: Text("An error occurred trying to delete the item: \(deleteItemErrorMessage)."),
                      dismissButton: .default(Text("OK")))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {showingNewItemPopover = true}) {
                        Label("Add Item", systemImage: "plus")
                    }.popover(isPresented: $showingNewItemPopover) {
                        NewGroceryView() { status, groceryitem, brand, highPriority in
                            showingNewItemPopover = false
                            if (status == "ok") {addItem(groceryitem: groceryitem, brand: brand, highPriority: highPriority)
                            }
                        }
                    }
                }
            }.navigationTitle("Grocery List")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let deleteItemError = error as NSError
                deleteItemErrorMessage = deleteItemError.description
                showingDeleteItemErrorAlert = true
            }
        }
    }
    
    private func addItem(groceryitem: String, brand: String, highPriority: Bool) {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.groceryitem = groceryitem
            newItem.highPriority = highPriority
            newItem.brand = brand
            newItem.createdOn = Date()
            newItem.completedOn = nil

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct GroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
    
