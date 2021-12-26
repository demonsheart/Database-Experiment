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
    
    static let shared = UserStateModel()
    
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
    let cusId: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case cusId = "cus_id"
        case password
    }
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
    let cusID: String
    let password: String
    let lastName: String
    let firstName: String
    let hometown: String
    let cellPhone: String
    let telephone: String
    let email: String
    let creditCard: String
    let isStudent: Int
    let license: String
    let state: String
    let expireDate: String
    let tickets: Int
    
    enum CodingKeys: String, CodingKey {
        case cusID = "cus_id"
        case password = "password"
        case lastName = "last_name"
        case firstName = "first_name"
        case hometown = "hometown"
        case cellPhone = "cell_phone"
        case telephone = "telephone"
        case email = "email"
        case creditCard = "credit_card"
        case isStudent = "is_student"
        case license = "license"
        case state = "state"
        case expireDate = "expire_date"
        case tickets = "tickets"
    }
}
