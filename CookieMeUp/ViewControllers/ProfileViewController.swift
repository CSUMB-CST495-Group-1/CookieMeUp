//
//  ProfileViewController.swift
//  CookieMeUp
//
//  Created by Sandra Flores on 4/3/18.
//  Copyright © 2018 CSUMB-CST495-Group-1. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePicImageView: PFImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var imageFile: PFFile!
    var userName: String!
    var firstName: String!
    var lastName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current().unsafelyUnwrapped
        firstName = user ["firstName"] as! String
        lastName = user["lastName"] as! String
        userName = user.username
        
        usernameLabel.text = userName
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        
        if let imageFile : PFFile = user["profilePhoto"] as? PFFile {
            imageFile.getDataInBackground(block: { (data, error) in
                if error == nil {
                    let image = UIImage(data: data!)
                    self.profilePicImageView.image = image
                } else {
                    print(error!.localizedDescription)
                }
            })
        }
    }

    @IBAction func logoutButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
