//
//  MockPersistenceController.swift
//  ListApp
//
//  Created by Samar Khaled on 16/01/2025.
//
import CoreData
@testable import ListApp

final class MockPersistenceController: PersistenceManaging {

    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    // Fetch objects properly within the context
    func fetchCountries() -> [CountryEntity] {
        let fetchRequest: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching countries: \(error)")
            return []
        }
    }

    // Save objects correctly
    func saveCountries(_ countries: [Country]) {
        countries.forEach { country in
            let entity = CountryEntity(context: context)
            entity.name = country.name.common
            entity.flag = country.flag
        }

        do {
            try context.save()
        } catch {
            print("Error saving countries: \(error)")
        }
    }
}
