//
//  ContentView.swift
//  SwireChat
//
//  Created by MATHEW DENNY on 31/1/22.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var isLogin = true
    @State var email = ""
    @State var password = ""
    @State var loginStatusMessage = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Picker(selection: $isLogin, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    if !isLogin {
                        Button {
                            print("*** Image upload ***")
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 72))
                                .foregroundColor(.green)
                                .padding()
                        }
                    }

                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .padding(8)
                    .background(Color.white)

                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLogin ? "Login" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                            Spacer()
                        }
                        .background(Color.green)
                    }

                    Text(loginStatusMessage)
                        .foregroundColor(.red)

                }
                .padding()
            }
            .navigationTitle(isLogin ? "Log In" : "Create Account")
            .background(Color(.init(gray: 0, alpha: 0.1)).ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func handleAction() {
        if isLogin {
            login()
        } else {
            createAccount()
        }
    }

    private func createAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.loginStatusMessage = error.localizedDescription
                return
            }
            self.loginStatusMessage = "Successfully created account"
        }
    }

    private func login() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                loginStatusMessage = "Failed to login! \(error.localizedDescription)"
                return
            }
            loginStatusMessage = "Successfully logged in as \(result?.user.uid ?? "-")"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
