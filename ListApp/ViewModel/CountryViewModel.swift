//
//  CountryViewModel.swift
//  ListApp
//
//  Created by Samar Khaled on 16/01/2025.
//
import Combine
import CoreData
import Foundation

struct IdentifiableError: Identifiable {
    let id = UUID()
    let message: String
}

final class CountryViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var error: IdentifiableError?
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()

    private var networkManager: NetworkManaging
    private var persistenceController: PersistenceManaging

    init(networkManager: NetworkManaging = NetworkManager(), persistenceController: PersistenceManaging) {
        self.networkManager = networkManager
        self.persistenceController = persistenceController

        loadCountries()
    }

    func loadCountries() {
        isLoading = true
        fetchCountriesFromCoreData()

        fetchCountriesFromAPI()
    }

    private func fetchCountriesFromCoreData() {
        let savedCountries = persistenceController.fetchCountries()
        countries = savedCountries.map { $0.toCountry() }
        isLoading = countries.isEmpty
    }

    private func fetchCountriesFromAPI() {
        networkManager.fetchCountries()
            .receive(on: DispatchQueue.main) // Ensure UI updates happen on the main thread
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = IdentifiableError(message: error.localizedDescription)
                    self?.isLoading = false
                }
            }, receiveValue: { [weak self] countries in
                self?.countries = countries
                self?.persistenceController.saveCountries(countries)
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
}
