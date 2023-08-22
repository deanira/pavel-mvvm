//
//  Items+CoreDataProperties.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 21/08/23.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isCheck: Bool
    @NSManaged public var name: String?
    @NSManaged public var total: Int32
    @NSManaged public var category: Categories?

}

extension Items : Identifiable {

}
