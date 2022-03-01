//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Miro on 2/26/22.
//

import UIKit

import Parse

class LoginViewController: UIViewController {

    //create fields for user + password
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text!
        
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, Error) in
            
            if user != nil { //perform login segue if login is valid
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            } else { //throw error if login is unsuccessful
                
                print("Error: \(Error?.localizedDescription)")
                
            }
            
        }
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        let user = PFUser()
        
        //get username + password fields for logging in
        
        user.username = usernameField.text
        
        user.password = passwordField.text
        
//        user.password = "myPassword"
        
        user.signUpInBackground { (success, error) in
            
            if success {
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            } else { //print out error
                
                print("Error: \(error?.localizedDescription)")
                
            }
            
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
