//
//  LoginViewController.swift
//  CookieMeUp
//
//  Created by Raquel Figueroa-Opperman on 3/13/18.
//  Copyright © 2018 CSUMB-CST495-Group-1. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernamefield: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
    }
    
    @IBAction func signup(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernamefield.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success, error) in
            if success {
                print ("Logged in!")
            } else {
                print (error?.localizedDescription)

            }
        }
    }
    
    


}
