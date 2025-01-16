//
//  CountryListView.swift
//  ListApp
//
//  Created by Samar Khaled on 16/01/2025.
//

import SwiftUI

struct CountryListView: View {
    @StateObject var viewModel: CountryViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    List(viewModel.countries) { country in
                        HStack(alignment: .center) {
                            Text(country.flag)
                            Text(country.name.common)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationTitle("Countries")
            .onAppear {
                viewModel.loadCountries()
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
