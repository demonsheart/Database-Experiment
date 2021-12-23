//
//  AnalyzeListView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI

struct AnalyzeListView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ProbationCusView()) {
                    Text("Probation Customers")
                }
                NavigationLink(destination: PopularLocsView()) {
                    Text("Popular Locations")
                }
                NavigationLink(destination: RentalTrendsView()) {
                    Text("Rental Trends")
                }
                .navigationTitle("Analyze")
            }
        }
    }
}

struct AnalyzeListView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeListView()
    }
}
