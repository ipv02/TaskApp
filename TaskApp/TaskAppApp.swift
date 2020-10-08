//
//  TaskAppApp.swift
//  TaskApp
//
//  Created by Elena Igumenova on 08.10.2020.
//

import SwiftUI

@main
struct TaskAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
