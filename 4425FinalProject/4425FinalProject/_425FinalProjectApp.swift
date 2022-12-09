//
//  _425FinalProjectApp.swift
//  4425FinalProject
//
//  Created by Hailey Jessee & Jack Stepanek on 11/28/22.
//

import SwiftUI

@main
struct _425FinalProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
