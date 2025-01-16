//
//  MockPersistenceController.swift
//  ListApp
//
//  Created by Samar Khaled on 16/01/2025.
//
import CoreData
@testable import ListApp

final class MockPersistenceController: PersistenceManaging {
    private var countries: [CountryEntity] = []

    func fetchCountries() -> [CountryEntity] {
        return countries
    }

    func saveCountries(_ countries: [Country]) {
        self.countries = countries.map { country in
            let entity = CountryEntity(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
            entity.name = country.name.common
            entity.flag = country.flag
            return entity
        }
    }
}
