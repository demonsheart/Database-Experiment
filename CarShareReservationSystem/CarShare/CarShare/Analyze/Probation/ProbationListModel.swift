//
//  ProbationListModel.swift
//  CarShare
//
//  Created by herongjin on 2021/12/23.
//

import Foundation

// MARK: - ProbationListModel
struct ProbationListModel: Codable {
    var cus: [ProbationCus]
    
    enum CodingKeys: String, CodingKey {
        case cus = "data"
    }
}

// MARK: - ProbationCus
struct ProbationCus: Identifiable, Codable {
    var id = UUID()
    
    var lastName: String
    var firstName: String
    var email: String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
        case email = "email"
    }
}
