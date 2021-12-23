//
//  RentalTrendsView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/23.
//

import SwiftUI

struct RentalTrendsView: View {
    @StateObject var viewModel = RentalTrendsViewModel()
    
    var body: some View {
        ScrollView {
            BarChart(title: "Student Rental Trends", legend: "", barColor: Color.random, data: viewModel.studentBarChartDataSet)
                .frame(height: 400)
                .navigationBarTitleDisplayMode(.inline)
            
            BarChart(title: "Not Student Rental Trends", legend: "", barColor: Color.random, data: viewModel.notStudentBarChartDataSet)
                .frame(height: 400)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RentalTrendsView_Previews: PreviewProvider {
    static var previews: some View {
        RentalTrendsView()
    }
}
