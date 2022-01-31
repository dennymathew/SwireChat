//
//  ContentView.swift
//  SwireChat
//
//  Created by MATHEW DENNY on 31/1/22.
//

import SwiftUI

struct LoginView: View {
    @State var isLogin = true
    @State var email = ""
    @State var password = ""
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
                }
                .padding()
            }
            .navigationTitle(isLogin ? "Log In" : "Create Account")
            .background(Color(.init(gray: 0, alpha: 0.1)))
        }
    }

    private func handleAction() {
        if isLogin {
            print("Attempt Firebase login with the existing credentials")
        } else {
            print("Attempt to register new user with the email and password")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
