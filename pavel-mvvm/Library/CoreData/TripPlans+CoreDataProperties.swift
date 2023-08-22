//
//  TripPlans+CoreDataProperties.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 21/08/23.
//
//

import Foundation
import CoreData


extension TripPlans {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripPlans> {
        return NSFetchRequest<TripPlans>(entityName: "TripPlans")
    }

    @NSManaged public var dateEnd: Date?
    @NSManaged public var dateStart: Date?
    @NSManaged public var destination: String?
    @NSManaged public var duration: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var isAbroad: Bool
    @NSManaged public var origin: String?
    @NSManaged public var status: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var categories: Categories?

}

extension TripPlans : Identifiable {

}
