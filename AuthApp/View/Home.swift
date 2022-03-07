//
//  Home.swift
//  AuthApp
//
//  Created by shehan karunarathna on 2022-03-07.
//

import SwiftUI
import Firebase

struct Home: View {
    @AppStorage("logs_status") var logstatus:Bool = false
    var body: some View {
        VStack(spacing:20){
            if logstatus {
                Text("Logged in ")
                Button ("Logout"){
                   try? Auth.auth().signOut()
                    logstatus = false
                }
            } else {
                Text("come as a guest")
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Home")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
