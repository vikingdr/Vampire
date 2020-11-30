//
//  Apps+CoreDataProperties.swift
//  
//
//  Created by Matthew James on 3/22/20.
//
//

import Foundation
import CoreData


extension Apps {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Apps> {
        return NSFetchRequest<Apps>(entityName: "Apps")
    }

    @NSManaged public var developer: String?
    @NSManaged public var developerAddress: String?
    @NSManaged public var developerEmail: String?
    @NSManaged public var developerWebsite: String?
    @NSManaged public var genreId: String?
    @NSManaged public var icon: String?
    @NSManaged public var installs: String?
    @NSManaged public var isSent: Bool
    @NSManaged public var keyword: String?
    @NSManaged public var recentChanges: String?
    @NSManaged public var released: Date?
    @NSManaged public var score: Float
    @NSManaged public var sentdate: Date?
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var updatedDate: Double
    @NSManaged public var url: String?
    @NSManaged public var version: String?
    @NSManaged public var files: Files?

}
