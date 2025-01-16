//
//  ListAppApp.swift
//  ListApp
//
//  Created by Samar Khaled on 14/01/2025.
//

import SwiftUI

@main
struct ListAppApp: App {
    private let persistenceController = PersistenceController()

    var body: some Scene {
        WindowGroup {
            CountryListView(viewModel: CountryViewModel(persistenceController: persistenceController))
                .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
