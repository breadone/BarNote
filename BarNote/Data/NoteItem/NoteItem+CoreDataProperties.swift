//
//  NoteItem+CoreDataProperties.swift
//  BarNote
//
//  Created by Pradyun Setti on 25/01/21.
//
//

import Foundation
import CoreData


extension NoteItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteItem> {
        return NSFetchRequest<NoteItem>(entityName: "NoteItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var colour: String?

}

extension NoteItem : Identifiable {

}
