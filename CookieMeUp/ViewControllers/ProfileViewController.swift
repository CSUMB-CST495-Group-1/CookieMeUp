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
        firstName = user["firstName"] as! String
        lastName = user["lastName"] as! String
        imageFile = user["profilePhoto"] as! PFFile
        userName = user.username
        
        usernameLabel.text = userName
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        //profilePicImageView.image = imageFile
        
        

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
