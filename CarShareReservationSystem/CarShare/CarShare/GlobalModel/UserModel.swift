//
//  UserModel.swift
//  CarShare
//
//  Created by herongjin on 2021/12/25.
//

import Foundation
import SwiftUI
import Combine

class UserStateModel: ObservableObject {
    @Published var user: UserModel?
    @Published var isError: Bool = false
    @Published var isLogin: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
    }
    
    func login(params: LoginModel, callback:@escaping ((Bool)->Void)) {
        self.isLogin = false
        self.user = nil
        dataManager.login(params: params)
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.isError = true
                } else {
                    self.user = dataResponse.value
                    if dataResponse.value!.success {
                        self.isLogin = true
                    }
                }
                callback(self.isLogin)
            }.store(in: &cancellableSet)
    }
    
    func logout() {
        self.isLogin = false
        self.user = nil
    }
}

// MARK: - LoginModel
struct LoginModel: Codable {
    let account: String
    let password: String
}


// MARK: - UserModel
struct UserModel: Codable {
    var data: User
    var success: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case success = "success"
    }
}

// MARK: - User
struct User: Codable {
    var cusID: Int
    var account: String
    var password: String
    var lastName: String
    var firstName: String
    var hometown: String
    var cellPhone: String
    var email: String
    var creditCard: String
    var isStudent: Int
    var licenseNumber: String
    var licenseState: String
    var expirationDate: String
    
    enum CodingKeys: String, CodingKey {
        case cusID = "cus_id"
        case account = "account"
        case password = "password"
        case lastName = "last_name"
        case firstName = "first_name"
        case hometown = "hometown"
        case cellPhone = "cell_phone"
        case email = "email"
        case creditCard = "credit_card"
        case isStudent = "is_student"
        case licenseNumber = "license_number"
        case licenseState = "license_state"
        case expirationDate = "expiration_date"
    }
}
