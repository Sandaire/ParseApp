//
//  ViewController.swift
//  ParseApp
//
//  Created by Sandyna Sandaire Jerome on 11/6/18.
//  Copyright © 2018 Sandyna Sandaire Jerome. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registerUser(_ sender: Any) {
        if(!(usernameField.text?.isEmpty)! && !(usernameField.text?.isEmpty)! && !(usernameField.text?.isEmpty)!){
            activityIndicator.startAnimating()
            // initialize a user object
            let newUser = PFUser()
            
            // set user properties
            newUser.username = usernameField.text
            newUser.email = emailField.text
            newUser.password = passwordField.text
            
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    self.activityIndicator.stopAnimating()
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                    self.activityIndicator.stopAnimating()
                    // manually segue to logged in view
                }
            }
        }else{
            print("Email, Password, username empty")
        }
    }

    @IBAction func loginUser(_ sender: Any) {
        activityIndicator.startAnimating()
        if(!(usernameField.text?.isEmpty)! && !(passwordField.text?.isEmpty)!){
            let username = usernameField.text ?? ""
            let password = passwordField.text ?? ""
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    self.activityIndicator.stopAnimating()
                    print("User log in failed: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "ERROR", message: "User log in failed...", preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                        // handle cancel response here. Doing nothing will dismiss the view.
                    }
                    // add the cancel action to the alertController
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
                } else {
                    self.activityIndicator.stopAnimating()
                    print("User logged in successfully")
                    // display view controller that needs to shown after successful login
                    self.performSegue(withIdentifier: "vcLogin", sender: nil)
                }
            }
        }else{
            self.activityIndicator.stopAnimating()
            let alertController = UIAlertController(title: "EMPTY FIELD", message: "Username or Password are empty...", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
    }
    
    
    
    
    
}

