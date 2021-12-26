//
//  LoginView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/25.
//

import SwiftUI
import Combine

struct LoginView: View {
    @ObservedObject var userState: UserStateModel = .shared
    @State var username: String = ""
    @State var password: String = ""
    @State var showingAlert: Bool = false
    let lightGreyColor = Color(#colorLiteral(red: 0.9294475317, green: 0.9239223003, blue: 0.9336946607, alpha: 1))
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            Image(systemName: "person.circle")
                .resizable()
                .foregroundColor(Color.green)
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .padding(.bottom, 40)
            
            TextField("Username", text: $username)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .autocapitalization(.none)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .autocapitalization(.none)
                .padding(.bottom, 20)
            
            NavigationLink(destination: RegisterFormView()) {
                Text("Create An account")
                    .foregroundColor(Color.blue)
            }
            
            Button(action: {
                userState.login(params: LoginModel(cusId: username, password: password)) { isLogin in
                    self.showingAlert = !isLogin
                }
            }) {
                Text("LOGIN")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Login Fail!"), message: nil, dismissButton: .cancel())
            }
            
            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
