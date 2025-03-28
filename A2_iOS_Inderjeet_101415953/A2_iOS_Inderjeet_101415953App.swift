//
//  A2_iOS_Inderjeet_101415953App.swift
//  A2_iOS_Inderjeet_101415953
//
//  Created by Inderjeet Kaur on 2025-03-28.
//

import SwiftUI

@main
struct A2_iOS_Inderjeet_101415953App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
