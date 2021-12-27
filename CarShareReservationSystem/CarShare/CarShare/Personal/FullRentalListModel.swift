//
//  FullRentalListModel.swift
//  CarShare
//
//  Created by aicoin on 2021/12/27.
//

import Foundation

// MARK: - FullRentalListModel
struct FullRentalListModel: Codable {
    let data: [FullRentalModel]
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case success = "success"
    }
}

// MARK: - FullRentalModel
struct FullRentalModel: Codable, Identifiable {
    let id = UUID()
    
    let rentalID: String
    let rentalDate: String
    let cusID: String
    let carID: Int
    let locID: Int
    let pickUpTime: String
    let dropOffTime: String
    let totalPrice: Double

    enum CodingKeys: String, CodingKey {
        case rentalID = "rental_id"
        case rentalDate = "rental_date"
        case cusID = "cus_id"
        case carID = "car_id"
        case locID = "loc_id"
        case pickUpTime = "pick_up_time"
        case dropOffTime = "drop_off_time"
        case totalPrice = "total_price"
    }
}
