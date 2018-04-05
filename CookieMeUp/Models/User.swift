//
//  User.swift
//  CookieMeUp
//
//  Created by Raquel Figueroa-Opperman on 4/2/18.
//  Copyright © 2018 CSUMB-CST495-Group-1. All rights reserved.
//

import Foundation
import Parse

class User: PFObject, PFSubclassing {
    
    @NSManaged var profilePhoto : PFFile
    @NSManaged var user: PFUser
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var isGirlScout: Bool
    @NSManaged var cookieLocations: Int
    
    static func parseClassName() -> String {
        return "User"
    }
    
    class func updateUserProfile(image: UIImage?, withFirstName firstName: String?, withLastName lastName: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        if let currentUser = PFUser.current(){
            currentUser["firstName"] = firstName!
            currentUser["lastName"] = lastName!
            currentUser["profilePhoto"] = getPFFileFromImage(image: image)! // PFFile column type
            
            // TODO: Get girl scout status from user
            currentUser["isGirlScout"] = false
            
//            TODO: Get cookie locations:
            currentUser["cookieLocations"] = 0

            
            // Save object (following function will save the object in Parse asynchronously)
            currentUser.saveInBackground(block: completion)
        } else {
            print ("Invalid User: Login again")
        }
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        } else {
            print ("no profile image chosen")
            let image : UIImage = UIImage(named:"profile_pic_placeholder")!

            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

}

