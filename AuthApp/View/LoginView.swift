//
//  LoginView.swift
//  AuthApp
//
//  Created by shehan karunarathna on 2022-03-07.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel : LoginViewModel = LoginViewModel()

    var body: some View {
        VStack{
            Circle()
                .trim(from: 0, to: 0.5)
                .fill(.black)
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: -90))
                .hleading()
                .offset(x: -20)
                .padding(.bottom , 30)
            Text("Login")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .hleading()
            
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(viewModel.email == "" ? Color.black.opacity(0.05) : Color.orange)
                )
                .padding(.top, 20)
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(viewModel.password == "" ? Color.black.opacity(0.05) : Color.orange)
                )
                .padding(.top, 15)
                .textInputAutocapitalization(.never)
            
            if viewModel.getBioMetricAuth() {
                
                Group{
                    if viewModel.useFaceId {
                        Button{
                            Task {
                                do {
                                    try await viewModel.authenticateUser()
                                } catch {
                                    viewModel.errorMsg = error.localizedDescription
                                    viewModel.showError.toggle()
                                }
                            }
                           
                        }label: {
                            VStack(alignment: .leading, spacing: 10) {
                                Label{
                                    Text("Use faceId to login to the system")
                                } icon: {
                                    Image(systemName: "faceid")
                                }
                                .font(.caption)
                                .foregroundColor(.gray)
                                
                                Text("You can turn off settings")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                        }
                        .hleading()
                    } else {
                        Toggle(isOn: viewModel.$useFaceId) {
                            Text("Use face id to login")
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
                .padding(.vertical, 20)
            }
            
          
            Button{
                Task{
                    do{
                        try await viewModel.loginUser()
                    }catch {
                        viewModel.errorMsg = error.localizedDescription
                        viewModel.showError.toggle()
                    }
                }
            }label: {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .hCenter()
                    .background(
                    RoundedRectangle(cornerRadius: 8)
                        
                    )
            }
            .padding(.vertical, 35)
            .disabled(viewModel.email == "" || viewModel.password == "")
            .opacity(viewModel.email == "" || viewModel.password == "" ? 0.5 : 1)
            
            NavigationLink{
                
            }label: {
                Text("Skip Now")
                    .foregroundColor(.gray)
            }
            
        }
        .padding()
        .alert(viewModel.errorMsg, isPresented: $viewModel.showError) {
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    func hleading() -> some View {
        self.frame(maxWidth:.infinity, alignment: .leading)
    }
    func hTrailing() -> some View {
        self.frame(maxWidth:.infinity, alignment: .trailing)
    }
    func hCenter() -> some View {
        self.frame(maxWidth:.infinity, alignment: .center)
    }
    
}
