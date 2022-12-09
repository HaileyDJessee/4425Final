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
                        TextField("Title", text: $groceryitem)
                        Toggle(isOn: $highPriority) {
                            Text("High Priority")
                        }
                        VStack {
                            HStack { Text("Brand:")
                                Spacer() }
                            TextEditor(text: $brand).frame(height: 200)
                                .font(.custom("HelveticaNeue", size: 14))
                                .lineSpacing(5)
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
                        Alert(title: Text("Missing Information"),
                              message: Text("A word must be provided for a new item."),
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
    }
    

}

struct NewGroceryView_Previews: PreviewProvider {

    static var previews: some View {
        NewGroceryView() { status, groceryitem, brand, highPriority in
        }
    }
}

