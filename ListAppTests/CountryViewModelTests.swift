//
//  CountryViewModelTests.swift
//  ListAppTests
//
//  Created by Samar Khaled on 16/01/2025.
//

import Combine
import CoreData
@testable import ListApp
import XCTest

final class CountryViewModelTests: XCTestCase {

    var viewModel: CountryViewModel!
    var mockNetworkManager: MockNetworkManager!
    var mockPersistenceController: MockPersistenceController!
    var cancellables: Set<AnyCancellable>!
    var persistentContainer: NSPersistentContainer!
    var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()

        // Create a fresh persistent container and context for each test
        persistentContainer = NSPersistentContainer(name: "DatabaseModel")
        let description = NSPersistentStoreDescription()
        description.type = NSSQLiteStoreType
        /// WWDC 2018:  https://developer.apple.com/videos/play/wwdc2018/224/?time=1838
        /// By using "/dev/null" core data will store the file in memory. This give us all the benefits of NSSQLiteStoreType but with memory
        description.url = URL(fileURLWithPath: "/dev/null")
        description.shouldAddStoreAsynchronously = false
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }

        context = persistentContainer.newBackgroundContext()

        mockNetworkManager = MockNetworkManager()
        mockPersistenceController = MockPersistenceController(context: context)
        viewModel = CountryViewModel(networkManager: mockNetworkManager, persistenceController: mockPersistenceController)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        // Reset context to clean up after each test
        context.reset()
        context.rollback()
        cancellables = nil
        viewModel = nil
        mockNetworkManager = nil
        mockPersistenceController = nil
        persistentContainer = nil
        super.tearDown()
    }

    func testLoadCountriesSuccess() {
        // Given
        mockNetworkManager.shouldReturnError = false
        let expectation = self.expectation(description: "Countries loaded successfully")

        // A flag to ensure we only fulfill the expectation once
        var hasFulfilled = false

        // When
        viewModel.loadCountries()

        // Listen for the `countries` array update
        viewModel.$countries
            .sink { countries in
                if countries.count > 0 && !hasFulfilled {
                    hasFulfilled = true
                    XCTAssertEqual(countries.count, 1)
                    XCTAssert(self.viewModel.isLoading)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Then
        XCTAssertTrue(viewModel.isLoading)

        // Wait for expectations
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testLoadCountriesFailure() {
        // Given
        mockNetworkManager.shouldReturnError = true
        let expectation = self.expectation(description: "Countries failed to load")

        // A flag to ensure we only fulfill the expectation once
        var hasFulfilled = false

        // When
        viewModel.loadCountries()

        // Listen for the `error` property update
        viewModel.$error
            .sink { error in
                if let error = error, !hasFulfilled {
                    hasFulfilled = true
                    XCTAssertEqual(error.message, URLError(.notConnectedToInternet).localizedDescription)
                    XCTAssertFalse(self.viewModel.isLoading)
                    expectation.fulfill() 
                }
            }
            .store(in: &cancellables)

        // Then
        XCTAssertTrue(viewModel.isLoading)

        // Wait for expectations
        waitForExpectations(timeout: 2, handler: nil)
    }
}
