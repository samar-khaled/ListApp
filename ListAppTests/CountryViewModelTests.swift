//
//  CountryViewModelTests.swift
//  ListAppTests
//
//  Created by Samar Khaled on 16/01/2025.
//

import XCTest
import Combine
@testable import ListApp

final class CountryViewModelTests: XCTestCase {
    
    var viewModel: CountryViewModel!
    var mockNetworkManager: MockNetworkManager!
    var mockPersistenceController: MockPersistenceController!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        mockPersistenceController = MockPersistenceController()
        viewModel = CountryViewModel(networkManager: mockNetworkManager, persistenceController: mockPersistenceController)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockNetworkManager = nil
        mockPersistenceController = nil
        super.tearDown()
    }

    func testLoadCountriesSuccess() {
        // Given
        mockNetworkManager.shouldReturnError = false

        // When
        viewModel.loadCountries()

        // Then
        XCTAssertTrue(viewModel.isLoading)
        
        // Wait for async updates
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.countries.count, 1)
            XCTAssertFalse(self.viewModel.isLoading)
        }
    }

    func testLoadCountriesFailure() {
        // Given
        mockNetworkManager.shouldReturnError = true

        // When
        viewModel.loadCountries()

        // Then
        XCTAssertTrue(viewModel.isLoading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.error)
            XCTAssertEqual(self.viewModel.error?.message, URLError(.notConnectedToInternet).localizedDescription)
            XCTAssertFalse(self.viewModel.isLoading)
        }
    }
}
