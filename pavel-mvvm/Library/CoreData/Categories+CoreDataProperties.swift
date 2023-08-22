//
//  Categories+CoreDataProperties.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 21/08/23.
//
//

import Foundation
import CoreData


extension Categories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var icon: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isWinter: Bool
    @NSManaged public var name: String?
    @NSManaged public var items: Items?
    @NSManaged public var trip: TripPlans?

}

extension Categories : Identifiable {

}
