//
//  PersistenceController.swift
//  ListApp
//
//  Created by Samar Khaled on 16/01/2025.
//

import CoreData
import SwiftUI

protocol PersistenceManaging {
    func fetchCountries() -> [CountryEntity]
    func saveCountries(_ countries: [Country]) -> Void
}

final class PersistenceController: PersistenceManaging {
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "DatabaseModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return container.viewContext
    }

    func fetchCountries() -> [CountryEntity] {
        let fetchRequest: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }

    func saveCountries(_ countries: [Country]) {
        let context = container.viewContext
        for country in countries {
            let entity = CountryEntity(context: context)
            entity.name = country.name.common
            entity.flag = country.flag
        }
        do {
            try context.save()
        } catch {
            print("Error saving countries to Core Data: \(error)")
        }
    }
}
