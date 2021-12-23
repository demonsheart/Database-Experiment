//
//  PopularLocsView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/23.
//

import SwiftUI

struct PopularLocsView: View {
    @StateObject var viewModel = PopularLocsViewModel()
    let bgColor = Color(hex: "29C6CD")
    
    var body: some View {
        ZStack {
            bgColor
                .edgesIgnoringSafeArea(.all)
            PieChartView(values: viewModel.values, names: viewModel.names, formatter: {value in String(format: "%.0f times", value)}, backgroundColor: bgColor)
                .navigationTitle("Popular Locations")
        }
    }
}

struct PopularLocsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularLocsView()
    }
}
