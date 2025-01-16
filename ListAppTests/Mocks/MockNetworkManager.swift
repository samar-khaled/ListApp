//
//  MockNetworkManager.swift
//  ListApp
//
//  Created by Samar Khaled on 16/01/2025.
//

import Combine
import Foundation
@testable import ListApp

final class MockNetworkManager: NetworkManaging {
    var shouldReturnError = false

    func fetchCountries() -> AnyPublisher<[Country], Error> {
        if shouldReturnError {
            return Fail(error: URLError(.notConnectedToInternet))
                .eraseToAnyPublisher()
        } else {
            let country = Country(
                name: Country.Name(common: "Norway", official: "Kingdom of Norway"),
                flag: "🇳🇴"
            )
            return Just([country])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
