//
//  RentalTrendListModel.swift
//  CarShare
//
//  Created by herongjin on 2021/12/23.
//

import Foundation

// MARK: - RentalTrendsListModel
struct RentalTrendsListModel: Codable {
    var trends: [Trend]
    
    enum CodingKeys: String, CodingKey {
        case trends = "data"
    }
}

// MARK: - Trend
struct Trend: Codable, Identifiable {
    var id = UUID()
    
    var make: String
    var model: String
    var isStudent: Int
    var numberOfTimesRented: Int
    
    enum CodingKeys: String, CodingKey {
        case make = "make"
        case model = "model"
        case isStudent = "is_student"
        case numberOfTimesRented = "number_of_times_rented"
    }
}
