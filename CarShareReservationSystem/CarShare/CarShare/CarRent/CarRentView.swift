//
//  CarRentView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI

struct CarRentView: View {
    
    @StateObject var viewModel = CarViewModel()
    let height: CGFloat = 130
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.cars) { car in
                        NavigationLink(destination: CarDetails(car: car)) {
                            CarView(picURL: car.picURL)
                        }
                        .navigationTitle("Rent")
                        .navigationBarHidden(true)
                        .frame(height: height)
                    }
                }
                .padding()
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
