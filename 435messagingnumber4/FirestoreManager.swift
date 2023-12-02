//
//  FirestoreManager.swift
//  435messagingnumber4
//
//  Created by Chase Morrone on 12/1/23.
//

import Foundation
import Firebase

import FirebaseFirestore

class FirestoreManager {
    let db = Firestore.firestore()

    func sendMessage(conversationId: String, senderId: String, messageText: String, completion: @escaping (Error?) -> Void) {
        let messageData: [String: Any] = [
            "senderId": senderId,
            "text": messageText,
            "timestamp": FieldValue.serverTimestamp()
        ]

        db.collection("Conversations").document(conversationId).collection("Messages")
            .addDocument(data: messageData) { error in
                completion(error)
            }
    }
    
    func fetchMessages(forConversationId conversationId: String, completion: @escaping ([Message]?, Error?) -> Void) {
        // Fetch messages for a conversation
        // Implement the logic to retrieve messages from Firestore based on the conversationId
        // Return messages or error via completion handler
    }
}



