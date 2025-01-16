//
//  Country.swift
//  ListApp
//
//  Created by Samar Khaled on 14/01/2025.
//

import Foundation

struct Country: Codable, Identifiable {
    var id: String { name.common }

    let name: Name
    let flag: String

    struct Name: Codable {
        let common: String
        let official: String
    }
}
