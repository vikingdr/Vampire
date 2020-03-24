//
//  Files+CoreDataProperties.swift
//  
//
//  Created by vikingdr on 3/22/20.
//
//

import Foundation
import CoreData


extension Files {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Files> {
        return NSFetchRequest<Files>(entityName: "Files")
    }

    @NSManaged public var fileName: String?
    @NSManaged public var isLoad: Bool
    @NSManaged public var loadDate: Date?

}
