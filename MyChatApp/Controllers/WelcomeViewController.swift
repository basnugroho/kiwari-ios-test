//
//  WelcomeViewController.swift
//  MyChatApp
//
//  Created by Baskoro Nugroho on 13/10/20.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        var index = 0.0
        let titleText = K.appName
        for char in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * index, repeats: false) { (timer) in
                self.titleLabel.text?.append(char)
            }
            index += 1
        }
    }


}
