//
//  LoginViewController.swift
//  MyChatApp
//
//  Created by Baskoro Nugroho on 13/10/20.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            emailTextfield.attributedPlaceholder = NSAttributedString(string: "Email",
                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            passwordTextfield.attributedPlaceholder = NSAttributedString(string: "Password",
                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
    
}
