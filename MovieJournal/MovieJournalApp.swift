//
//  MovieJournalApp.swift
//  MovieJournal
//
//  Created by CETYS Universidad  on 19/02/25.
//
import Foundation
import SwiftUI

@main
struct MovieJournalApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            TabsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
