//
//  PopularLocsListModel.swift
//  CarShare
//
//  Created by herongjin on 2021/12/23.
//

import Foundation

// MARK: - PopularLocsListModel
struct PopularLocsListModel: Codable {
    var locs: [PopularLoc]
    
    enum CodingKeys: String, CodingKey {
        case locs = "data"
    }
}

// MARK: - PopularLoc
struct PopularLoc: Identifiable, Codable {
    var id = UUID()
    
    var locID: Int
    var streetAddress: String
    var telephoneNumber: String
    var numberOfRentals: Int
    
    enum CodingKeys: String, CodingKey {
        case locID = "loc_id"
        case streetAddress = "street_address"
        case telephoneNumber = "telephone_number"
        case numberOfRentals = "number_of_rentals"
    }
}
