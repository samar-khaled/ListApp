//
//  Item.swift
//  ListApp
//
//  Created by Samar Khaled on 14/01/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
