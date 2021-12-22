//
//  CarListModel.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let car = try? newJSONDecoder().decode(Car.self, from: jsonData)

import Foundation

// MARK: - CarListModel
struct CarListModel: Codable {
    var cars: [Car]
    
    enum CodingKeys: String, CodingKey {
        case cars = "data"
    }
}

// MARK: - Car
struct Car: Identifiable, Codable {
    var id = UUID()
    
    var carID: Int
    var make: String
    var model: String
    var pricePerHour: Double
    var pricePerDay: Int
    var capacity: Int
    var picURL: String
    
    enum CodingKeys: String, CodingKey {
        case carID = "car_id"
        case make = "make"
        case model = "model"
        case pricePerHour = "price_per_hour"
        case pricePerDay = "price_per_day"
        case capacity = "capacity"
        case picURL = "pic_url"
    }
}
