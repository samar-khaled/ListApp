# Country Info App

This iOS app displays a list of countries, their names, and flags, utilizing a clean MVVM architecture with Core Data for persistence. It fetches country data from a network API, handles errors gracefully, and provides offline viewing by storing data locally.

# Features

**Fetches country data:** Uses a network manager to make API requests to fetch country information (e.g., names).

**Displays country information:** Presents a list of countries on the main screen with their respective flags.

**Offline storage:** Uses Core Data to persist country data for offline viewing.

**Error handling:** Displays error messages if the network request fails.

**Unit tests:** The app is unit tested to ensure functionality.


# Architecture

The app follows the MVVM (Model-View-ViewModel) architecture to separate concerns and keep code maintainable.

**MVVM Overview**
Model: Represents the data and business logic. In this case, the Country model represents the country data, and the CountryEntity is the Core Data model entity used for persistence.

View: The user interface, implemented using SwiftUI, displays the list of countries and their flags.

ViewModel: Handles the logic of fetching country data from the network or Core Data, updating the view, and handling user interactions. The CountryViewModel is responsible for managing data binding to the view and making decisions related to network requests and local persistence.

Core Data: The app uses Core Data for persistence. The CountryEntity class is the Core Data model that stores country information locally, allowing offline viewing. This class maps to the country data fetched from the API and persists the data for later use.

# Requirements

iOS 15.0+: The minimum supported iOS version.

Core Data for local persistence.

SwiftUI for the UI.

Combine for reactive programming.

# App Flow

**Fetch Data:** On app launch, the app checks if country data is already available in Core Data. If data exists, it is displayed. Otherwise, it fetches data from the network.

**Display Data:** The country list is updated with the fetched or cached data. The list shows the country name, and flag.

**Error Handling:** If the network request fails, an error message is shown, and the app tries to load data from Core Data if available.


# Testing

**Unit Tests**
Unit tests are implemented for the following features:

**Loading countries:** Verifies that the country data is correctly fetched from the network and displayed in the view.

**Error handling:** Tests the behavior when the network request fails.

**Persistence:** Ensures that country data is correctly saved to Core Data and loaded from it when needed.

