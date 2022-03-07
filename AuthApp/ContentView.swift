//
//  ContentView.swift
//  AuthApp
//
//  Created by shehan karunarathna on 2022-03-07.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("logs_status") var logstatus:Bool = false
    var body: some View {
        NavigationView{
            if logstatus {
                Home()
            } else {
                LoginView()
                    .navigationBarHidden(true)
            }
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
