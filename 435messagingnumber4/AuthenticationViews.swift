//
//  AuthenticationViews.swift
//  435messagingnumber4
//
//  Created by Chase Morrone on 12/1/23.
//

import Foundation
import SwiftUI
import Firebase

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    let authManager = AuthenticationManager()

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Sign In") {
                authManager.signIn(email: email, password: password) { _, error in
                    if let error = error {
                        print("Sign-in error:", error.localizedDescription)
                        // Handle error display or action accordingly
                    } else {
                        // Navigate to next view upon successful sign-in
                    }
                }
            }
            .padding()
        }
    }
}

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedUp=false
    @State private var signUpError: Error?
    @State private var shouldReenterCredentials = false
    @State private var showAlert = false
    @State private var error: Error?
    @State private var errorMessage: String?

    let authManager = AuthenticationManager()
    func signUp() {
        // Call your authentication manager's sign-up method here
        authManager.signUp(email: email, password: password) { result, error in
            if let error = error {
                // Handle sign-up error
                signUpError = error.localizedDescription as! any Error
                print("Sign-up error:", error.localizedDescription)
                shouldReenterCredentials = true // Prompt user to re-enter credentials
            } else {
                // Navigate or perform actions upon successful sign-up
                isSignedUp = true
                // For example:
                // Navigate to the main message center or perform additional setup
            }
        }
    }

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Sign Up") {
                authManager.signUp(email: email, password: password) { _, error in
                    if let error = error {
                        showAlert = true // Show alert for re-entering credentials
                        errorMessage = error.localizedDescription
                    } else {
                        isSignedUp = true // Activate sheet for MainMessagesView
                    }
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
            .padding()
        }
        .navigationTitle("Sign Up")
        .alert(isPresented: $showAlert) {
            if shouldReenterCredentials {
                return Alert(
                    title: Text("Error"),
                    message: Text("Please re-enter your email and password."),
                    dismissButton: .default(Text("OK")) {
                        // Optionally clear the email and password fields here
                    }
                )
            } else {
                return Alert(
                    title: Text("Error"),
                    message: Text(errorMessage ?? "Unknown error occurred."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .sheet(isPresented: $isSignedUp) {
            MainMessagesView() // Present the main message center upon successful sign-up
        }
        
    }
    
}
   
