//
//  SignUpView.swift
//  PayItFwd
//
//  Created by Laiba Ahmed on 2026-04-12.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPassword: Bool = false
    @State private var errorMessage: String? = nil

    let green = Color(red: 50/255, green: 100/255, blue: 30/255)

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {

                VStack(spacing: 8) {
                    Image(systemName: "hands.sparkles.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(green)

                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(green)

                    Text("Join the PayItFwd community.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 40)

                VStack(spacing: 16) {

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Full Name")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)

                        HStack {
                            Image(systemName: "person")
                                .foregroundStyle(.secondary)
                            TextField("Your name", text: $name)
                                .autocorrectionDisabled()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)

                        HStack {
                            Image(systemName: "envelope")
                                .foregroundStyle(.secondary)
                            TextField("you@example.com", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)

                        HStack {
                            Image(systemName: "lock")
                                .foregroundStyle(.secondary)
                            if showPassword {
                                TextField("Password", text: $password)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                            } else {
                                SecureField("Password", text: $password)
                            }
                            Button {
                                showPassword.toggle()
                            } label: {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Confirm Password")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)

                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundStyle(.secondary)
                            SecureField("Confirm password", text: $confirmPassword)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }

                    if let error = errorMessage {
                        HStack(spacing: 6) {
                            Image(systemName: "exclamationmark.circle.fill")
                            Text(error)
                                .font(.footnote)
                        }
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal)

                Button {
                    signUp()
                } label: {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(green)
                        .frame(height: 52)
                        .overlay {
                            Text("Create Account")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                }
                .padding(.horizontal)

                HStack(spacing: 4) {
                    Text("Already have an account?")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Button("Log In") {
                        dismiss()
                    }
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(green)
                }

                Spacer()
            }
        }
    }

    func signUp() {
        errorMessage = nil

        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter your name."
            return
        }
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, email.contains("@") else {
            errorMessage = "Please enter a valid email."
            return
        }
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters."
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        authViewModel.isLoggedIn = true
        dismiss()
    }
}
