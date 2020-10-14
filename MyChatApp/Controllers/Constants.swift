//
//  Constants.swift
//  MyChatApp
//
//  Created by Baskoro Nugroho on 13/10/20.
//

struct K {
    static let appName = "💬 MyChatApp"
    static let cellIdentifier = "ReusableCell"
    static let userIdentifier = "userIdentifier"
    static let cellNibName = "ChatCell"
    static let registerSegue = "RegisterToMessageList"
    static let loginSegue = "LoginToMessageList"
    static let messageSegue = "MessageListToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let nameField = "name"
        static let bodyField = "body"
        static let dateField = "date"
    }
}

