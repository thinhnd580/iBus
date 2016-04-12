//
//  Route+CoreDataProperties.swift
//  iBus
//
//  Created by Thinh on 4/12/16.
//  Copyright © 2016 Thinh Nguyen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Route {

    @NSManaged var busNumber: String?
    @NSManaged var tripDetail: String?
    @NSManaged var routeTrip: String?
    @NSManaged var goPoints: NSSet?
    @NSManaged var returnPoints: NSSet?
    func addGoPointObject(value:Point) {
//        let items = self.mutableSetValueForKey("points");
//        items.addObject(value)
        self.goPointArray.insert(value, atIndex: self.goPointArray.count)
    }
    
    func getGoPointArray() -> [AnyObject] {
        return self.goPointArray
    }
    
    func removePointObject(value:Point) {
        let items = self.mutableSetValueForKey("points");
        items.removeObject(value)
    }
}
