//
//  ContentView.swift
//  435messagingnumber4
//
//  Created by Chase Morrone on 12/1/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    let SenderID = "YourSenderId"
    let ReceiverID = "yourreceiverID"
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Messaging App")
                    .font(.title)
                    .padding()

                NavigationLink(destination: ChatView(receiverID:ReceiverID, senderID: SenderID)) {
                    Text("Start Chatting")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Messaging App")
        }
    }
}

