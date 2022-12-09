//
//  NewGroceryView.swift
//  4425FinalProject
//
//  Created by Hailey Jessee & Jack Stepanek on 11/28/22.
//

import SwiftUI

struct NewGroceryView: View {
    
    @State var showingSaveItemErrorAlert = false
    
    @State var groceryitem: String = ""
    @State var brand: String = ""
    @State var highPriority: Bool = false
    
    let completionHandler: (String, String, String, Bool) -> Void
    
    init(completionHandler: @escaping  (String, String, String, Bool) -> Void) {
        self.completionHandler = completionHandler
    }
    
    var body: some View {
        NavigationView {
                Form {
                    Section() {
                        TextField("Grocery Item", text: $groceryitem)
                        Toggle(isOn: $highPriority) {
                            Text("High Priority Item?")
                        }
                        VStack {
                            TextField("Brand", text: $brand)
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                if (groceryitem == "") {
                                    showingSaveItemErrorAlert = true
                                } else {
                                    completionHandler("ok", groceryitem, brand, highPriority)
                                }
                                
                            }) { Text("Save") }
                            Spacer()
                        }
                    }.alert(isPresented: $showingSaveItemErrorAlert) {
                        Alert(title: Text("Missing Information!"),
                              message: Text("A grocery item must be provided."),
                              dismissButton: .default(Text("OK")))
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
             .navigationBarTitle(Text("New Grocery Item"))
             .navigationBarItems(trailing: Button(action: {
                completionHandler("cancel", "", "", false)
             }, label: {
                 Text("Cancel")
             }))
        }
        .padding()
    }
    

}

struct NewGroceryView_Previews: PreviewProvider {

    static var previews: some View {
        NewGroceryView() { status, groceryitem, brand, highPriority in
        }
    }
}

