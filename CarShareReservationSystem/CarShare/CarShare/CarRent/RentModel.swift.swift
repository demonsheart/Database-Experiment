//
//  RentModel.swift.swift
//  CarShare
//
//  Created by aicoin on 2021/12/27.
//

import Foundation

//{
//    "rental_date": "2010-02-03",
//    "pick_up_time": "2010-02-17 19:00:00",
//    "drop_off_time": "2010-02-17 19:30:00",
//    "cus_id": "M-62",
//    "car_id": 101,
//    "loc_id": 60
//}

struct RentModel: Codable {
    let rentalDate: String
    let pickUpTime: String
    let dropOffTime: String
    let cusID: String
    let carID: Int
    let locID: Int

    enum CodingKeys: String, CodingKey {
        case rentalDate = "rental_date"
        case pickUpTime = "pick_up_time"
        case dropOffTime = "drop_off_time"
        case cusID = "cus_id"
        case carID = "car_id"
        case locID = "loc_id"
    }
}
