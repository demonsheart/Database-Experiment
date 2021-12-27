//
//  LocModel.swift
//  CarShare
//
//  Created by aicoin on 2021/12/27.
//

import Foundation

// MARK: - PopularLocsListModel
struct LocsListModel: Codable {
    var locs: [Loc]
    
    enum CodingKeys: String, CodingKey {
        case locs = "data"
    }
}

// MARK: - PopularLoc
struct Loc: Identifiable, Codable {
    var id = UUID()
    
    var locID: Int
    var streetAddress: String
    var telephoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case locID = "loc_id"
        case streetAddress = "street_address"
        case telephoneNumber = "telephone_number"
    }
}
