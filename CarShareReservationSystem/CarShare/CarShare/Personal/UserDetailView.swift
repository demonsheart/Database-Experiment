//
//  UserDetailView.swift
//  CarShare
//
//  Created by aicoin on 2021/12/25.
//

import SwiftUI

struct UserDetailView: View {
    @ObservedObject var userState: UserStateModel = .shared
    var user: User
    
    var body: some View {
        VStack {
            List {
                UserDetailBar(title: "account", content: user.cusID)
                UserDetailBar(title: "name", content: user.firstName + " " + user.lastName)
                UserDetailBar(title: "hometown", content: user.hometown)
                UserDetailBar(title: "cellPhone", content: user.cellPhone)
                UserDetailBar(title: "email", content: user.email)
                UserDetailBar(title: "creditCard", content: user.creditCard)
                UserDetailBar(title: "isStudent", content: "\(user.isStudent)")
                UserDetailBar(title: "licenseNumber", content: user.license)
                UserDetailBar(title: "licenseState", content: user.state)
                UserDetailBar(title: "expirationDate", content: user.expireDate.convertDate())
            }
            .navigationBarTitleDisplayMode(.inline)
            
            Button(action: {
                userState.logout()
            }) {
                Text("LOGOUT")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.red)
                    .cornerRadius(15.0)
            }
            Spacer()
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User(cusID: "333", password: "", lastName: "RJ", firstName: "H", hometown: "GuangDong", cellPhone: "7758258",telephone: "7777777" , email: "2509875617@qq.com", creditCard: "0438038", isStudent: 1, license: "888888", state: "valid", expireDate: "2027-12-17 00:00:00", tickets: 3))
    }
}

struct UserDetailBar: View {
    var title: String
    var content: String
    
    var body: some View {
        if content != "" {
            HStack {
                Text("\(title):")
                    .foregroundColor(Color(hex: "1E212D"))
                    .font(.custom("Georgia", size: 20))
                Spacer()
                Text(content)
                    .foregroundColor(Color.gray)
                    .font(.custom("Georgia", size: 18))
            }
        }
    }
}
