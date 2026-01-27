//
//  RegistrationView.swift
//  SupabaseMarketplace
//
//  Created by Frank Bara on 12/31/25.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    @State private var passwordsMatch = false
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(.supabase)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
            
            Spacer()
            
            VStack(spacing: 8) {
                TextField("Enter your email", text: $email)
                    .autocapitalization(.none)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                
                TextField("Enter your username", text: $username)
                    .autocapitalization(.none)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                
                ZStack(alignment: .trailing) {
                    SecureField("Enter your password", text: $password)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    if !password.isEmpty && !confirmedPassword.isEmpty {
                        Image(systemName: passwordsMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundStyle(passwordsMatch ? .green : .red)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal, 24)
                
                ZStack(alignment: .trailing) {
                    SecureField("Confirm your password", text: $confirmedPassword)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    if !password.isEmpty && !confirmedPassword.isEmpty {
                        Image(systemName: passwordsMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundStyle(passwordsMatch ? .green : .red)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal, 24)
                .onChange(of: confirmedPassword) { oldValue, newValue in
                    passwordsMatch = newValue == password
                }
            }
            
            Button { signUp() } label: {
                Text("Sign Up")
                    .font(.headline)
                    .frame(width: 360, height: 48)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
            }
            // form validation
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            
            Spacer()
            
            Divider()
            
            Button { dismiss() } label: {
                HStack(spacing: 3) {
                    Text("Already have an account")
                    
                    Text("Sign up")
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
            }
            .padding(.vertical, 16)
        }
    }
}

private extension RegistrationView {
    func signUp() {
        Task {
            isLoading = true
            // call the authManager signup function
            await authManager.signUp(
                email: email,
                password: password,
                username: username
            )
            isLoading = false
        }
    }
    
    var formIsValid: Bool {
        return email.isValidEmail() && passwordsMatch && username.count > 1
    }
}

#Preview {
    RegistrationView()
        .environment(AuthManager())
}
