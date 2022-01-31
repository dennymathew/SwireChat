//
//  FirebaseManager.swift
//  SwireChat
//
//  Created by MATHEW DENNY on 31/1/22.
//

import Firebase

final class FirebaseManager: NSObject {

    let auth: Auth
    static let shared = FirebaseManager()

    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        super.init()
    }
}
