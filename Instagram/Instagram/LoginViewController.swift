//
//  LoginViewController.swift
//  Instagram
//
//  Created by Chase McCoy on 3/1/16.
//  Copyright © 2016 Chase McCoy. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
  @IBOutlet var usernameField: UITextField!
  @IBOutlet var passwordField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func onSignIn(sender: UIButton) {
    let username = usernameField.text ?? ""
    let password = passwordField.text ?? ""
    
    PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
      if let error = error {
        print("User login failed.")
        print(error.localizedDescription)
      } else {
        print("User logged in successfully")
        // display view controller that needs to shown after successful login
        NSNotificationCenter.defaultCenter().postNotificationName("userDidLogin", object: nil)
      }
    }
  }
  
  @IBAction func onSignUp(sender: UIButton) {
    let newUser = PFUser()
    
    // set user properties
    newUser.username = usernameField.text
    newUser.password = passwordField.text
    
    // call sign up function on the object
    newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
      if let error = error {
        print(error.localizedDescription)
        if error.code == 202 {
          print("Username is taken")
        }
      } else {
        print("User Registered successfully")
        // manually segue to logged in view
        NSNotificationCenter.defaultCenter().postNotificationName("userDidLogin", object: nil)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
