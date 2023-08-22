//
//  Documents+CoreDataProperties.swift
//  pavel-mvvm
//
//  Created by Deanira Fadrinaldi on 21/08/23.
//
//

import Foundation
import CoreData


extension Documents {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Documents> {
        return NSFetchRequest<Documents>(entityName: "Documents")
    }

    @NSManaged public var category: String?
    @NSManaged public var file: String?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?

}

extension Documents : Identifiable {

}
