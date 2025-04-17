//
//  ReviewEntity+CoreDataProperties.swift
//  MovieJournal
//
//  Created by Claudia Moca on 17/04/25.
//
//

import Foundation
import CoreData


extension ReviewEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReviewEntity> {
        return NSFetchRequest<ReviewEntity>(entityName: "ReviewEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var movieId: UUID?
    @NSManaged public var rating: String?
    @NSManaged public var review: String?
    @NSManaged public var selfie: Data?

}
