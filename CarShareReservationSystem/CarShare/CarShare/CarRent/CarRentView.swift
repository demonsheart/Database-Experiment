//
//  CarRentView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI

struct CarRentView: View {
    @StateObject var viewModel = CarViewModel()
    @ObservedObject var userState: UserStateModel = .shared
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Stepper(value: $viewModel.curNum, in: viewModel.minMaxCapacity) {
                    HStack {
                        Text("Min of Passagers: \(self.viewModel.curNum)")
                            .font(Font.custom("Pacifico-Regular", size: 20))
                            .bold()
                            .foregroundColor(Color(hex: "1E212D"))
                            .padding(.leading)
                        Image(systemName: "person.3")
                            .scaledToFit()
                            .gesture(
                                TapGesture()
                                    .onEnded({ _ in
                                        viewModel.getData()
                                    })
                            )
                            .offset(y: 3)
                    }
                }
                Divider()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(viewModel.filterCar) { car in
                            NavigationLink(destination: CarDetails(car: car)) {
                                CarView(picURL: car.picURL)
                            }
                            .navigationTitle("Rent")
                            .navigationBarHidden(true)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct CarRentView_Previews: PreviewProvider {
    static var previews: some View {
        CarRentView()
    }
}
