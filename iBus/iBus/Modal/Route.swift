//
//  Route.swift
//  iBus
//
//  Created by Thinh on 4/12/16.
//  Copyright © 2016 Thinh Nguyen. All rights reserved.
//

import Foundation
import CoreData

@objc(Route)
class Route: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    var goPointArray:[AnyObject] = []
    var returnPointArray:[AnyObject] = []
}
