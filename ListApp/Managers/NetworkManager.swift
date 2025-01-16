//
//  NetworkManager.swift
//  ListApp
//
//  Created by Samar Khaled on 14/01/2025.
//

import Combine
import Foundation

protocol NetworkManaging {
    func fetchCountries() -> AnyPublisher<[Country], Error>
}

final class NetworkManager: NetworkManaging {

    init() {}

    private let apiURL = "https://restcountries.com/v3.1/region/europe"

    func fetchCountries() -> AnyPublisher<[Country], Error> {
        guard let url = URL(string: apiURL) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Country].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
