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
        return "UserProfile"
    }
    
    class func updateUserProfile(image: UIImage?, withFirstName firstName: String?, withLastName lastName: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        let userProfile = User()
        
        userProfile.user = PFUser.current()! // Pointer column type that points to PFUser
        userProfile.profilePhoto = getPFFileFromImage(image: image)! // PFFile column type
        userProfile.cookieLocations = 0
        userProfile.firstName = firstName!
        userProfile.lastName = lastName!
//        user.isGirlScout = false

        
        // Save object (following function will save the object in Parse asynchronously)
        userProfile.saveInBackground(block: completion)
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

