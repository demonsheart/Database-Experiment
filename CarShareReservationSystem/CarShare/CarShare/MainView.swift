//
//  MainView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI

struct MainView: View {
    let userState = UserStateModel()
    
    var body: some View {
        TabView {
            CarRentView()
                .tabItem {
                    Label("Rent", systemImage: "car")
                }
                .environmentObject(userState)
            AnalyzeListView()
                .tabItem {
                    Label("Analyze", systemImage: "hourglass.circle")
                }
                .environmentObject(userState)
            PersonalMessView()
                .tabItem {
                    Label("Person", systemImage: "person")
                }
                .environmentObject(userState)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
