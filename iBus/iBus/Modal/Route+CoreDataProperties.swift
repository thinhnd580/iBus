//
//  Route+CoreDataProperties.swift
//  iBus
//
//  Created by Thinh on 4/11/16.
//  Copyright © 2016 Thinh Nguyen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Route {

    @NSManaged var id: NSNumber?
    @NSManaged var detail: String?
    @NSManaged var buses: NSSet?
    @NSManaged var points: Point?

}
