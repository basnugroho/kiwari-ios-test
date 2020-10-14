//
//  ChatViewController.swift
//  MyChatApp
//
//  Created by Baskoro Nugroho on 13/10/20.
//

import UIKit
import FirebaseAuth
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    var senderName: String?
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        setCurrentSenderName()
        // show name and image at navbar
        if let sender = senderName {
            addImageAndFriendNameAtNavbar(sender)
        }
        // fetch data from firestore
        loadMessages()
        
        // chat room appearance
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        messageTextField.backgroundColor = UIColor.white
    }
    
    func addImageAndFriendNameAtNavbar(_ senderName: String) {
        
        var friendName = "Jarjit Singh"
        var friendAvatar = "jarjit@mail.com"
        if senderName == "Jarjit Singh" {
            friendName = "Ismail bin Mail"
            friendAvatar = "ismail@mail.com"
        }
        // Only execute the code if there's a navigation controller
        if self.navigationController == nil {
            return
        }

        // Create a navView to add to the navigation bar
        let navView = UIView()

        // Create the label
        let label = UILabel()
        label.text = friendName
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center

        // Create the image view
        let image = UIImageView()
        image.image = UIImage(named: friendAvatar)
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
    
    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let e = error {
                print("error retrieving data \(e)")
            } else {
                if let snapshotDocument = querySnapshot?.documents {
                    for doc in snapshotDocument {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String,
                           let messageSenderName = data[K.FStore.nameField] as? String,
                           let messageBody = data[K.FStore.bodyField] as? String,
                           let messageDate = data[K.FStore.dateField] as? Double {
                            let newMessage = Message(sender: messageSender, senderName: messageSenderName, body: messageBody, date: NSDate(timeIntervalSince1970: messageDate))
                            self.messages.append(newMessage)

                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setCurrentSenderName() {
        if let emailLogin = Auth.auth().currentUser?.email {
            if emailLogin == "jarjit@mail.com" {
                senderName = "Jarjit Singh"
            } else {
                senderName = "Ismail bin Mail"
            }
        }
    }

    @IBAction func sendPressed(_ sender: Any) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.nameField: self.senderName ?? "",
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: NSDate().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("something wrong while saving data into firestore: \(e)")
                } else {
                    print("save data success")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
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
    
    func dateToStringFormated(date: Date) -> String {
        let d = date
        let df = DateFormatter()
        df.dateFormat = "MM-dd-y (H:mm:ss)"
        return df.string(from: d)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! ChatCell
        cell.nameLabel?.text = messages[indexPath.row].senderName
        cell.bodyLabel?.text = messages[indexPath.row].body
        cell.timeLabel?.text = dateToStringFormated(date: messages[indexPath.row].date as Date)
        return cell
    }
}

