//
//  CarRentView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI

struct CarRentView: View {
    
    @StateObject var viewModel = CarViewModel()
    @State var minNum: String = ""
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                // FIXME: dddd
//                Picker("Please choose a color", selection: $minNum) {
//                    ForEach(viewModel.minMaxCapacity, id: \.self) {
//                        Text($0)
//                    }
//                }
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
        .onAppear {
            viewModel.getData()
        }
    }
}

struct CarRentView_Previews: PreviewProvider {
    static var previews: some View {
        CarRentView()
    }
}
