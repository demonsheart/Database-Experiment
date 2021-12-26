//
//  CarRentDetailView.swift
//  CarShare
//
//  Created by aicoin on 2021/12/26.
//

import SwiftUI

struct CarRentDetailView: View {
    @ObservedObject var userState: UserStateModel = .shared
    
    var body: some View {
        Text("\(userState.isLogin ? "true": "false")")
    }
}

struct CarRentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CarRentDetailView()
    }
}
