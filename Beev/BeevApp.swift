//
//  BeevApp.swift
//  Beev
//
//  Created by Michela D'Avino on 08/05/24.
//

import SwiftUI

@main
struct BeevApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

        }
        .environment(\.colorScheme, .dark)
    }
}
