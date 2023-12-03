//
//  MessagingViews.swift
//  435messagingnumber4
//
//  Created by Chase Morrone on 12/1/23.
//

import Foundation
import SwiftUI
import Firebase
struct Message{
    var id: UUID
    var text: String
    let senderID: String // Assuming you store sender's ID
    
    func isSentBy(userID: String) -> Bool {
        return senderID == userID
    }
}
struct ChatView: View {
    @ObservedObject var firebaseManager = FirebaseManager()
    @State private var messageText = ""
    @State private var messages: [Message] = [] // Store received messages here
    let receiverID: String
    let id = UUID()
    let senderID: String
    var body: some View {
        VStack {
            ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(messages, id: \.id) { message in
                            Text(message.text)
                                            }
                            }
                            .padding()
                        }
            }
            
            HStack {
                TextField("Type a message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Send") {
                    let newMessage = Message(id: id, text: messageText, senderID: senderID)

                    firebaseManager.sendMessage(messageText: messageText, senderID: senderID, receiverID: receiverID)
                    messageText = "" // Clear the message input field after sending
                }
                .padding()
            }
        
        .navigationTitle("Chat")
        .onReceive(firebaseManager.$messages) { receivedMessages in self.messages = receivedMessages
            
                }
                .onAppear {
                    // Listen for new messages
                    firebaseManager.observeMessages(receiverID: receiverID)
                }
    }
}
struct MessageView: View {
    let receiverID: String
    let id = UUID()
    let senderID: String
    let message: Message
    var isSentByCurrentUser = false
    var body: some View {
        HStack {
            if message.isSentBy(userID: senderID ) {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                Text(message.text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Spacer()
            }
        }
    }
}
