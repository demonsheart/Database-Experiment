//
//  PersonalMessView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI

struct PersonalMessView: View {
    @EnvironmentObject var userState: UserStateModel
    
    var body: some View {
        NavigationView {
            List {
                if let user = userState.user {
                    NavigationLink(destination: Text("Null")) {
                        UserInfoView(firstName: user.data.firstName, lastName: user.data.lastName, email: user.data.email)
                    }
                    .navigationTitle("personal")
                    .navigationBarHidden(true)
                } else {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                    }
                    .navigationTitle("personal")
                    .navigationBarHidden(true)
                    .environmentObject(userState)
                }
            }
        }
    }
}

struct PersonalMessView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalMessView()
    }
}
