//
//  Product+CoreDataProperties.swift
//  A2_iOS_Inderjeet_101415953
//
//  Created by Inderjeet Kaur on 2025-03-28.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var price: Double
    @NSManaged public var provider: String?

}

extension Product : Identifiable {

}
