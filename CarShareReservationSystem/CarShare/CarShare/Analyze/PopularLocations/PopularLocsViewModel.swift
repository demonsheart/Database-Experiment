//
//  PopularLocsViewModel.swift
//  CarShare
//
//  Created by herongjin on 2021/12/23.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class PopularLocsViewModel: ObservableObject {
    
    @Published var locs: [PopularLoc] = []
    @Published var isError: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    var values: [Double] {
        locs.map { Double($0.numberOfRentals) }
    }
    
    var names: [String] {
        locs.map { $0.streetAddress }
    }
    
    var colors: [Color] {
        var cls: [Color] = []
        for _ in 0..<locs.count {
            cls.append(Color.random)
        }
        return cls
    }
    
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
        getData()
    }
    
    func getData() {
        dataManager.getPopularLocsList()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.isError = true
                } else {
                    self.locs = dataResponse.value!.locs
                    self.locs.sort { $0.numberOfRentals > $1.numberOfRentals }
                }
            }.store(in: &cancellableSet)
    }
}
