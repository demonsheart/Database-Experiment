//
//  MyRentalsView.swift
//  CarShare
//
//  Created by aicoin on 2021/12/27.
//

import SwiftUI

struct MyRentalsView: View {
    
    @StateObject var model = MyRentalsViewModel()
    
    var body: some View {
        List {
            ForEach(model.rentals) { rental in
                Section {
                    Text("date: " + rental.rentalDate)
                    Text("carID: \(rental.carID)")
                    Text("locID: \(rental.locID)")
                    Text("pickUpTime: \(rental.pickUpTime)")
                    Text("dropOffTime: \(rental.dropOffTime)")
                    Text("totalPrice: \(rental.totalPrice)")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyRentalsView_Previews: PreviewProvider {
    static var previews: some View {
        MyRentalsView()
    }
}
