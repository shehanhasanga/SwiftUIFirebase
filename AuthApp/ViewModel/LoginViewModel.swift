//
//  LoginViewModel.swift
//  AuthApp
//
//  Created by shehan karunarathna on 2022-03-07.
//

import Foundation
import SwiftUI
import Firebase
import LocalAuthentication

class LoginViewModel:ObservableObject{
    @Published var email:String = ""
    @Published var password : String = ""
    
    @Published var showError : Bool = false
    @Published var errorMsg : String = ""
    
    @AppStorage("use_face_id") var useFaceId:Bool = false
    @AppStorage("use_face_email") var faceIdEmail:String = ""
    @AppStorage("use_face_password") var faceIdPassword:String = ""
    
    
    
    @AppStorage("logs_status") var logstatus:Bool = false
    
    func loginUser(autologin: Bool = false) async throws {
        if autologin {
            email = "shehan@gmail.com"
            password = "shehan"
        }
        let _ = try await Auth.auth().signIn(withEmail: email, password: password)
        
        if useFaceId {
            faceIdEmail = email
            faceIdPassword = password
        }
        DispatchQueue.main.async {
            self.logstatus = true
        }
        
    }
    
    func getBioMetricAuth() -> Bool{
        let scanner = LAContext()
        return scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
    func authenticateUser () async throws {
        let status = try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To login to app")
        if status {
           try await loginUser(autologin: true)
        }
    }
    
}
