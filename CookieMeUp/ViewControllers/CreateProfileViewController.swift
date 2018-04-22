//
//  CreateProfileViewController.swift
//  CookieMeUp
//
//  Created by Raquel Figueroa-Opperman on 4/2/18.
//  Copyright © 2018 CSUMB-CST495-Group-1. All rights reserved.
//

import UIKit
import Parse

class CreateProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func updateProfileImageButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func submitProfileButton(_ sender: Any) {
        if (passwordText.text != confirmPasswordText.text){
            let alertController = UIAlertController(title: "Passwords do not match.", message: "Please, try again.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.viewDidLoad()
            }
            alertController.addAction(okAction)
            passwordText.text = ""
            confirmPasswordText.text = ""
            self.present(alertController, animated: true){
            }
        }
        else if ((firstNameText.text?.isEmpty)! || (lastNameText.text?.isEmpty)! || (usernameText.text?.isEmpty)! || (passwordText.text?.isEmpty)! || (confirmPasswordText.text?.isEmpty)!) {
            let alertController = UIAlertController(title: "Cannot submit with empty fields", message: "Please, try again.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.viewDidLoad()
            }
            alertController.addAction(okAction)
            passwordText.text = ""
            confirmPasswordText.text = ""
            self.present(alertController, animated: true){
            }
            
        }
        
        else {
            let newUser = PFUser()
            newUser.username = usernameText.text
            newUser.password = passwordText.text
    
            newUser.signUpInBackground { (success, error) in
                if success {
                    print ("Created Profile!")
                    User.updateUserProfile(image: self.uploadImage.image, withFirstName: self.firstNameText.text, withLastName: self.lastNameText.text) { (success, error) in
                        if success {
                            print ("Saved Profile!")
                        }
                        else {
                            print (error?.localizedDescription)
                        }
            //        dismiss(animated: true, completion: nil)
            
                    }
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
    
    
    
    @IBAction func logoutButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    

    
    @IBAction func cancelButton(_ sender: Any) {
        print("profile view cancel button pressed")
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        var editedImage = originalImage
        editedImage = resize(image: editedImage, newSize: CGSize(width: 300, height: 300))
        
        // Do something with the images
        uploadImage.image = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height:newSize.height)))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
