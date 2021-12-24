//
//  CarRentView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI

struct CarRentView: View {
    
    @StateObject var viewModel = CarViewModel()
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField("Enter Search Capacity", text: $viewModel.searchText)
                    .padding(.horizontal, 40)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 45, alignment: .leading)
                    .background(Color(#colorLiteral(red: 0.9294475317, green: 0.9239223003, blue: 0.9336946607, alpha: 1)))
                    .clipped()
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 16)
                        }
                    )
                
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
