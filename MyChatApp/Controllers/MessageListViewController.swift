//
//  MessageListViewController.swift
//  MyChatApp
//
//  Created by Baskoro Nugroho on 13/10/20.
//

import UIKit
import FirebaseAuth

class MessageListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let users: [User] = [
        User(email: "jarjit@mail.com", name: "Jarjit Singh", avatarUrl: "jarjit@mail.com"),
        User(email: "ismail@mail.com", name: "Ismail bin Mail", avatarUrl: "ismail@mail.com")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = K.appName
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
}

extension MessageListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.userIdentifier, for: indexPath) as UITableViewCell
        
        if let user = Auth.auth().currentUser {

            if String(user.email!) == "jarjit@mail.com" {
                cell.textLabel?.text = users[1].name
                if let image : UIImage = UIImage(named: users[1].avatarUrl) {
                    cell.imageView!.image = image
                }
            } else {
                cell.textLabel?.text = users[0].name
                if let image : UIImage = UIImage(named: users[0].avatarUrl) {
                    cell.imageView!.image = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: K.messageSegue, sender: self)
    }
}
