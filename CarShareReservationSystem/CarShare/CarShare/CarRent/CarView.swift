//
//  CarView.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import SwiftUI
import Kingfisher

struct CarView: View {
    
    let picURL: String
    
    var body: some View {
        VStack {
            KFImage(URL(string: picURL))
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
        }
    }
}

struct CarView_Previews: PreviewProvider {
    static var previews: some View {
        CarView(picURL: "https://s2.loli.net/2021/12/21/4wzUqSflsbaOZ3J.jpg")
    }
}
