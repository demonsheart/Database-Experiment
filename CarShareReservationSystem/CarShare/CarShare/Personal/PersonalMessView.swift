//
//  PersonalMessView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI

struct PersonalMessView: View {
    @ObservedObject var userState: UserStateModel = .shared
    
    var body: some View {
        NavigationView {
            List {
                if let user = userState.user {
                    NavigationLink(destination: UserDetailView(user: user.data)) {
                        UserInfoView(firstName: user.data.firstName, lastName: user.data.lastName, email: user.data.email)
                    }
                    .navigationTitle("personal")
                    .navigationBarHidden(true)
                    
                    NavigationLink(destination: MyRentalsView()) {
                        Text("My rentals")
                    }
                    .navigationTitle("personal")
                    .navigationBarHidden(true)
                } else {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                    }
                    .navigationTitle("personal")
                    .navigationBarHidden(true)
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
