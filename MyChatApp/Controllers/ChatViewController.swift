//
//  ChatViewController.swift
//  MyChatApp
//
//  Created by Baskoro Nugroho on 13/10/20.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        addNavBarOpponentImage()
    }
    
    func showOpponentChat() {
        

    }
    
    func addNavBarOpponentImage() {
        // Only execute the code if there's a navigation controller
        if self.navigationController == nil {
            return
        }

        // Create a navView to add to the navigation bar
        let navView = UIView()

        // Create the label
        let label = UILabel()
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center

        // Create the image view
        let image = UIImageView()
        
        if let user = Auth.auth().currentUser {
            if String(user.email!) == "jarjit@mail.com" {
                label.text = "IsmailbinMail"
                image.image = UIImage(named: "ismail@mail.com")
            } else if String(user.email!) == "ismail@mail.com" {
                label.text = "JarjitSingh"
                image.image = UIImage(named: "jarjit@mail.com")
            } else {
                label.text = K.appName
                image.image = UIImage(named: "ismail@mail.com")
            }
        }
        
        
        // To maintain the image's aspect ratio:
        let imageAspect = image.image!.size.width/image.image!.size.height
        // Setting the image frame so that it's immediately before the text:
        image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        image.contentMode = UIView.ContentMode.scaleAspectFit

        // Add both the label and image view to the navView
        navView.addSubview(label)
        navView.addSubview(image)

        // Set the navigation bar's navigation item's titleView to the navView
        self.navigationItem.titleView = navView

        // Set the navView's frame to fit within the titleView
        navView.sizeToFit()
    }

    @IBAction func sendPressed(_ sender: Any) {
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

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
}

