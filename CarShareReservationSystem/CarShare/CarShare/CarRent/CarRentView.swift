//
//  CarRentView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI

struct CarRentView: View {
    
    @ObservedObject var viewModel = CarViewModel()
    let height: CGFloat = 130
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.cars) { car in
                    CarView(picURL: car.picURL)
                        .frame(height: height)
                        .gesture(
                            TapGesture()
                                .onEnded({ _ in
                                    print(car)
                                })
                        )
                }
            }
            .padding()
        }
    }
}

struct CarRentView_Previews: PreviewProvider {
    static var previews: some View {
        CarRentView()
    }
}
