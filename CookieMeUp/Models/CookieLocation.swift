//
//  CookieLocation.swift
//  CookieMeUp
//
//  Created by Raquel Figueroa-Opperman on 4/2/18.
//  Copyright © 2018 CSUMB-CST495-Group-1. All rights reserved.
//

import Foundation
import Parse

class CookieLocation: UITableViewCell {

    
    @NSManaged var longitude : String
    @NSManaged var latitude: String
    @NSManaged var location_photo: PFFile
    @NSManaged var date: Date
    @NSManaged var start_time: String
    @NSManaged var ending_time: String
    @NSManaged var girl_scout_verified: Bool
    @NSManaged var user: User
    
    static func parseClassName() -> String {
        return "CookieLocation"
    }
    
    

}
