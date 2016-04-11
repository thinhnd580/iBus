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

    @NSManaged var detail: String?
    @NSManaged var id: NSNumber?
    @NSManaged var bus: Bus?
    @NSManaged var points: NSSet?
    
    func addPointObject(value:Point) {
        let items = self.mutableSetValueForKey("points");
        items.addObject(value)
    }
    func removePointObject(value:Point) {
        let items = self.mutableSetValueForKey("points");
        items.removeObject(value)
    }
}
