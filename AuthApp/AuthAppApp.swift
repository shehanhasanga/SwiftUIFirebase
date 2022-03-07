//
//  AuthAppApp.swift
//  AuthApp
//
//  Created by shehan karunarathna on 2022-03-07.
//

import SwiftUI
import Firebase

@main
struct AuthAppApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
