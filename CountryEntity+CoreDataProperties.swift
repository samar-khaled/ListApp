//
//  CountryEntity+CoreDataProperties.swift
//  ListApp
//
//  Created by Samar Khaled on 16/01/2025.
//
//

import Foundation
import CoreData


extension CountryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryEntity> {
        return NSFetchRequest<CountryEntity>(entityName: "CountryEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var code: String?
    @NSManaged public var flag: String?
    @NSManaged public var region: String?
    @NSManaged public var subregion: String?
    @NSManaged public var population: Int32

}

extension CountryEntity : Identifiable {

}
