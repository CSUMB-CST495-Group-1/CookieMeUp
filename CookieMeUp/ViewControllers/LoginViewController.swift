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
    @IBOutlet weak var usernameField: UITextField!
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
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (PFUser, NSError) in
            if (PFUser != nil){
                print ("Login successful!")
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else if ((self.usernameField.text!.isEmpty) || (self.passwordField.text!.isEmpty)){
                let alertController = UIAlertController(title: "Cannot leave a field empty.", message: "Please, try again.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.viewDidLoad()
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true){
                }
            } else {
                let alertController = UIAlertController(title: "Invalid Username/Password", message: "Please, try again.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.viewDidLoad()
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true){}
            }
        }
    }
    
    @IBAction func signup(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success, error) in
            if success {
                print ("Logged in!")
                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
            } else {
                let alertController = UIAlertController(title: "Invalid Username/Password", message: "Please, try again.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.viewDidLoad()
                }
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true){
                }
            }
            
            
        }
    }
    
    


}
