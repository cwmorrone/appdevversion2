//
//  FirebaseManager.swift
//  435messagingnumber4
//
//  Created by Chase Morrone on 12/1/23.
//

import Foundation
import Firebase

class FirebaseManager: ObservableObject {
    let db = Firestore.firestore()
        @Published var messages: [Message] = []
    func saveUserData(userId: String, username: String, email: String) {
            let userRef = db.collection("users").document(userId)

            userRef.setData([
                "username": username,
                "email": email,
                // Add more fields as needed
            ]) { error in
                if let error = error {
                    print("Error saving user data: \(error.localizedDescription)")
                } else {
                    print("User data saved successfully")
                }
            }
        }

        func fetchUserData(for userId: String, completion: @escaping ([String: Any]?) -> Void) {
            let userRef = db.collection("users").document(userId)

            userRef.getDocument { document, error in
                if let document = document, document.exists {
                    let userData = document.data()
                    completion(userData)
                } else {
                    completion(nil)
                }
            }
        }
    func fetchUsername(for userId: String, completion: @escaping (String?) -> Void) {
        let userRef = db.collection("users").document(userId)

        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let userData = document.data()
                if let username = userData?["username"] as? String {
                    completion(username)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
        func sendMessage(messageText: String, senderID: String, receiverID: String) {
            
            let newMessage = Message(id: UUID(), text: messageText, senderID: senderID)
            // Save the message to the Firebase database
            db.collection("conversations").document(receiverID).collection("messages").addDocument(data: [
                "text": messageText,
                "senderID": senderID
            ])
        }
        
        func observeMessages(receiverID: String) {
            db.collection("conversations").document(receiverID).collection("messages").addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                self.messages = documents.compactMap { document in
                    let data = document.data()
                    if let text = data["text"] as? String,
                       let senderID = data["senderID"] as? String {
                        return Message(id: UUID(), text: text, senderID: senderID)
                    } else {
                        // Customize this return if necessary based on your logic
                        return Message(id: UUID(), text: "", senderID: "")
                    }
                }
            }
        }
}
