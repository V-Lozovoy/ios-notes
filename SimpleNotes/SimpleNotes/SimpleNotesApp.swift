//  SimpleNotesApp.swift
//  SimpleNotes

import SwiftUI

@main // точка входу до застосунку
struct SimpleNotesApp: App {
    let persistenceController = PersistenceController.shared // створюємо єдиний екземпляр контролера для роботи з нашою базою даних

    var body: some Scene {
        WindowGroup {
            ContentView() // Головний екран (View), який буде показаний користувачеві при запуску застосунку
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
