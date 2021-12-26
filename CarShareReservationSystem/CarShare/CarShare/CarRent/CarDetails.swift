//
//  CarDetails.swift
//  CarShare
//
//  Created by herongjin on 2021/12/23.
//

import SwiftUI
import Kingfisher

struct CarDetails: View {
    let car: Car
    @ObservedObject var userState: UserStateModel = .shared
    
    var body: some View {
        ZStack {
            Color(hex: "CDF0EA")
                .edgesIgnoringSafeArea(.all)
            VStack {
                KFImage(URL(string: car.picURL))
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(hex: "F4F9F9"), lineWidth: 5))
                
                Text(car.make)
                    .font(Font.custom("Pacifico-Regular", size: 30))
                    .bold()
                    .foregroundColor(Color(hex: "1E212D"))
                
                Text(car.model)
                    .foregroundColor(Color(hex: "1E212D"))
                    .font(.custom("Georgia", size: 20))
                
                Divider()
                
                InfoView(imgName: "person.3.sequence", pricePer: "\(car.capacity)", subffix: "Seats")
                InfoView(imgName: "dollarsign.circle.fill", pricePer: "\(car.pricePerDay)", subffix: "Per Day")
                InfoView(imgName: "dollarsign.circle.fill", pricePer: "\(car.pricePerHour)", subffix: "Per Hour")
                
                Divider()
                
                NavigationLink(destination: CarRentDetailView()) {
                    Text("Rent it")
                        .foregroundColor(Color(hex: "1E212D"))
                        .font(Font.custom("Pacifico-Regular", size: 30))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 3)
                        )
                }
                .navigationTitle("Rent")
                .navigationBarTitleDisplayMode(.inline)
                
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CarDetails_Previews: PreviewProvider {
    static var previews: some View {
        CarDetails(car: Car(carID: 101, make: "Subaru", model: "Impreza", pricePerHour: 3.9, pricePerDay: 39, capacity: 5, picURL: "https://cdn.jsdelivr.net/gh/demonsheart/Pic@main/car/car1.jpg", description: "4 seats"))
    }
}

struct InfoView: View {
    let imgName: String
    let pricePer: String
    let subffix: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 40)
            .foregroundColor(Color(hex: "FEFFDE"))
            .overlay(HStack{
                Image(systemName: imgName)
                    .foregroundColor(Color(hex: "F58840"))
                Text(String(pricePer))
                Text(subffix)
                    .font(Font.custom("VujahdayScript-Regular", size: 20))
                    .bold()
            })
            .padding(.horizontal)
    }
}
