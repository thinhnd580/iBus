//
//  Route+CoreDataProperties.swift
//  iBus
//
//  Created by Thinh Nguyen on 4/13/16.
//  Copyright © 2016 Thinh Nguyen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Route {

    @NSManaged var busNumber: String?
    @NSManaged var routeTrip: String?
    @NSManaged var tripDetail: String?
    @NSManaged var goPoints: NSOrderedSet?
    @NSManaged var returnPoints: NSOrderedSet?

}
