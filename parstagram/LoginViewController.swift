//
//  LoginViewController.swift
//  parstagram
//
//  Created by Arun Deepak Sampath Kumar on 10/19/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var usernameFIeld: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signin(_ sender: Any) {
        
        let username = usernameFIeld.text!
        let password = passwordField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
              if user != nil {
                          self.performSegue(withIdentifier: "loginSegue", sender: nil)
                      } else{
                          print("Error:\(error?.localizedDescription)")
                      }        }
        
    }
    
    
    @IBAction func signup(_ sender: Any) {
    let user = PFUser()
        user.username = usernameFIeld.text
        user.password = passwordField.text
        user.signUpInBackground {  (success,error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else{
                print("Error:\(error?.localizedDescription)")
            }
        }
  
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
