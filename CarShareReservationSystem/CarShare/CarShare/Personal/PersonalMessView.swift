//
//  PersonalMessView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI

struct PersonalMessView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ProbationCusView()) {
                    Text("Probation Customers")
                }
                .navigationTitle("personal")
                .navigationBarHidden(true)
            }
        }
    }
}

struct PersonalMessView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalMessView()
    }
}
