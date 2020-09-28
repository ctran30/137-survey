//
//  ViewController.swift
//  137_project
//
//  Created by Connie Tran on 9/27/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "toHomeView", sender: self)
        }
    }

    @IBAction func signUpPressed(_ sender: Any) {
        performSegue(withIdentifier: "toSetUp", sender: self)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil {
                //method signs in, and if no error, segues into home view to create surveys
                print("Signed in")
                self.performSegue(withIdentifier: "toHomeView", sender: self)
            } else {
                //method signs in, and if error, sends error message and prevents user from entering home view
                print("Could not sign in")
                let errorAlert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                errorAlert.addAction(defaultAction)
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

