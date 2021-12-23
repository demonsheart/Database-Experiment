//
//  ProbationCusView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/23.
//

import SwiftUI

struct ProbationCusView: View {
    @StateObject var viewModel = ProbationViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.cus) { cus in
                HStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .foregroundColor(Color(hex: "B1D0E0"))
                        .frame(width: 30, height: 30)
                    VStack {
                        Text(cus.lastName)
                            .font(Font.custom("Pacifico-Regular", size: 15))
                            .bold()
                            .foregroundColor(Color(hex: "1E212D"))
                        Text(cus.firstName)
                            .font(Font.custom("Pacifico-Regular", size: 10))
                            .foregroundColor(Color(hex: "1E212D"))
                    }
                    Spacer()
                    Text(cus.email)
                }
            }
        }
        .navigationTitle("Probation Customers")
    }
}

struct ProbationCusView_Previews: PreviewProvider {
    static var previews: some View {
        ProbationCusView()
    }
}
