//
//  MainView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CarRentView()
                .tabItem {
                    Label("Rent", systemImage: "car")
                }
            AnalyzeListView()
                .tabItem {
                    Label("Analyze", systemImage: "hourglass.circle")
                }
            PersonalMessView()
                .tabItem {
                    Label("Person", systemImage: "person")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
