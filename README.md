# kiwari-ios-test
a simple iOS chat Application based on firestore.

## Take a look

<center>
<img src=Docs/welcome-screen.gif width=150>
<img src=Docs/login.png width=150>
<img src=Docs/message.png width=150>
<img src=Docs/chat_room.png width=150>
</center>

## Specifications

- [x] **Build tools:** Swift 5 and Xcode 12.0.1
- [x] **Source and branch management:** Git
- [x] **Dependency management:** CocoaPod and Swift Package Dependencies
- [x] **Supporting Tools**: Terminal

## Run the project

1. unzip
2. `cd` to the unzipped folder
3. run `pod install`
4. open MyChatApp.xcworkspace with Xcode 12 or higher
5. press <kbd>⌘ command </kbd> + <kbd> B </kbd> to build and run

## Checklist

- [x] Two Hardcoded Users
- Login Page
    - [x] Input Email
    - [x] Input Password
    - [x] Button Login
- ChatroomPage
    - navBar
        - [x] user can see avatar opponent user
        - [x] user can see name opponent user
    - messagelist
        - [x] user can see message item
    - message item
        - [x] user can see message content text
        - [x] user can see message date sent   
    - input text message
        - [x] user can see input text
        - [x] user can see button to send message text
    - menu logout
        - [x] user can logout and show login
