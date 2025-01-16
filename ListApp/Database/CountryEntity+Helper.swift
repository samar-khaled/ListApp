//
//  CountryEntity+Helper.swift
//  ListApp
//
//  Created by Samar Khaled on 16/01/2025.
//

import CoreData
import Foundation

extension CountryEntity {
    func toCountry() -> Country {
        return Country(
            name: Country.Name(common: name ?? "", official: ""),
            flag: flag ?? ""
        )
    }
}
