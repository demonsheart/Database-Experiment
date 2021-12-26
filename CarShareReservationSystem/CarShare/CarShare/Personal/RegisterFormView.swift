//
//  RegisterFormView.swift
//  CarShare
//
//  Created by aicoin on 2021/12/25.
//

import SwiftUI

struct RegisterFormView: View {
    @State var showAlertScc: Bool = false
    
    @ObservedObject var model = RegisterViewModel()
    @State private var usernameAvailable = false
    @State private var pwAvailable = false
    @State private var signUpDisabled = false
    
    var buttonColor: Color {
        return signUpDisabled ? Color.red : Color.green
    }
    
    var body: some View {
        Form {
            Section(header: Text("Account Message")) {
                HStack {
                    TextField("Account", text: $model.account)
                        .autocapitalization(.none)
                    Text(usernameAvailable ? "✅" : "❌")
                        .onReceive(model.validatedUsername) {
                            usernameAvailable = $0 != nil
                        }
                }
                SecureField("Password", text: $model.password)
                    .autocapitalization(.none)
                HStack {
                    SecureField("Comfirm Password", text: $model.password2)
                        .autocapitalization(.none)
                    Text(pwAvailable ? "✅" : "❌")
                        .onReceive(model.validatedPassword) {
                            pwAvailable = $0 != nil
                        }
                }
            }
            
            Section(header: Text("user info")) {
                HStack {
                    TextField("FirstName", text: $model.firstName)
                    Divider()
                    TextField("LastName", text: $model.lastName)
                }
                TextField("HomeTown", text: $model.hometown)
                TextField("CellPhone", text: $model.cellPhone)
                    .keyboardType(.numbersAndPunctuation)
                TextField("TelePhone", text: $model.telePhone)
                    .keyboardType(.numbersAndPunctuation)
                TextField("Email", text: $model.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                HStack {
                    Text("Is student?")
                        .foregroundColor(Color.gray)
                    
                    Picker("Is student?", selection: $model.isStudent) {
                        ForEach(model.isStudents, id: \.self) { i in
                            Text("\(i)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                TextField("Credit Card", text: $model.credit)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("card info")) {
                TextField("License", text: $model.license)
                    .keyboardType(.numberPad)
                DatePicker(selection: $model.date, in: ...Date(), displayedComponents: .date) {
                    Text("expire_date")
                }
                TextField("tickets", text: $model.tickers)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("license state?")) {
                Picker("state:", selection: $model.state) {
                    ForEach(model.states, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            .listRowBackground(Color.clear)
            
            
            Button(action: {
                model.register() { success in
                    print(success)
                    self.showAlertScc = success
                }
            }) {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(buttonColor)
                    .cornerRadius(15.0)
            }
            .alert(isPresented: $showAlertScc) {
                Alert(title: Text("Register Success!"), message: nil, dismissButton: .cancel())
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
            .disabled(signUpDisabled)
            .onReceive(model.validatedCredentials) {
                if $0 == nil {
                    self.signUpDisabled = true
                    return
                }
                self.signUpDisabled = false
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
//    "cus_id": "F-50",
//    "password": "knskncs",
//    "last_name": "Franco",
//    "first_name": "Gianne",
//    "hometown": "1012 Peachtree St",
//    "cell_phone": "404-765-1263",
//    "telephone": "404-887-2342",
//    "email": "gf59@gmail.com",
//    "credit_card": "443398764532",
//    "license": "88765",
//    "state": "GA",
//    "expire_date": "2015-08-09 00:00:00",
//    "tickets": 0,
//    "is_student": 0
//}
