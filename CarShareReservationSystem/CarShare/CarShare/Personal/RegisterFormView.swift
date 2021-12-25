//
//  RegisterFormView.swift
//  CarShare
//
//  Created by aicoin on 2021/12/25.
//

import SwiftUI

struct RegisterFormView: View {
    @State var account: String = ""
    @State var password: String = ""
    @State var password2: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("account", text: $account)
                    .autocapitalization(.none)
                SecureField("password", text: $password)
                    .autocapitalization(.none)
                SecureField("comfirm password", text: $password2)
                    .autocapitalization(.none)
            }
        }
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct RegisterFormView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterFormView()
    }
}

//{
//    "account": "demo11",
//    "password": "hjtryy",
//    "last_name": "RJ",
//    "first_name": "H",
//    "hometown": "GuangDong",
//    "cell_phone": "77582508",
//    "email": "2509875617@qq.com",
//    "credit_card": "0438038",
//    "is_student": 1,
//    "license_number": "888888",
//    "license_state": "valid",
//    "expiration_date": "2027-12-17 00:00:00"
//}
