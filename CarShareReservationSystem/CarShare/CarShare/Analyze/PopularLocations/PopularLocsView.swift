//
//  PopularLocsView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/23.
//

import SwiftUI

struct PopularLocsView: View {
    @StateObject var viewModel = PopularLocsViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.locs) { loc in
                Text("\(loc.numberOfRentals)")
            }
        }
    }
}

struct PopularLocsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularLocsView()
    }
}
