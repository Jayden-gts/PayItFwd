//
//  LoginView.swift
//  PayItFwd
//
//  Created by Laiba Ahmed on 2026-04-12.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false

    private let validEmail = "user@payitfwd.com"
    private let validPassword = "password123"

    func login() {
        errorMessage = nil

        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter your email."
            return
        }
        guard !password.isEmpty else {
            errorMessage = "Please enter your password."
            return
        }
        guard email.contains("@") else {
            errorMessage = "Please enter a valid email address."
            return
        }

        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            if self.email == self.validEmail && self.password == self.validPassword {
                self.isLoggedIn = true
            } else {
                self.errorMessage = "Incorrect email or password. Please try again."
            }
        }
    }

    func logout() {
        isLoggedIn = false
        email = ""
        password = ""
        errorMessage = nil
    }
}

struct LoginView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @EnvironmentObject var listingViewModel: ServiceListingViewModel
    @State private var showPassword: Bool = false
    @State private var showSignUp: Bool = false

    let green = Color(red: 50/255, green: 100/255, blue: 30/255)

    var body: some View {
        if authViewModel.isLoggedIn {
            MainTabView()
                .environmentObject(listingViewModel)
                .environmentObject(authViewModel)
        } else {
            loginForm
        }
    }

    var loginForm: some View {
        ScrollView {
            VStack(spacing: 28) {

                VStack(spacing: 8) {
                    Image(systemName: "hands.sparkles.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(green)

                    Text("PayItFwd")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(green)

                    Text("Exchange services, build community.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 60)

                VStack(spacing: 16) {

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)

                        HStack {
                            Image(systemName: "envelope")
                                .foregroundStyle(.secondary)
                            TextField("you@example.com", text: $authViewModel.email)
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
                                TextField("Password", text: $authViewModel.password)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                            } else {
                                SecureField("Password", text: $authViewModel.password)
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

                    if let error = authViewModel.errorMessage {
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
                    authViewModel.login()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(green)
                            .frame(height: 52)

                        if authViewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Log In")
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.horizontal)
                .disabled(authViewModel.isLoading)

                HStack {
                    Rectangle().frame(height: 1).foregroundStyle(Color(.systemGray5))
                    Text("or").font(.footnote).foregroundStyle(.secondary)
                    Rectangle().frame(height: 1).foregroundStyle(Color(.systemGray5))
                }
                .padding(.horizontal)

                HStack(spacing: 4) {
                    Text("Don't have an account?")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Button("Sign Up") {
                        showSignUp = true
                    }
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(green)
                }

                Spacer()
            }
        }
        .sheet(isPresented: $showSignUp) {
            SignUpView(authViewModel: authViewModel)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(ServiceListingViewModel())
}
