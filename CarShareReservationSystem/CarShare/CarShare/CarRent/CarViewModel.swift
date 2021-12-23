//
//  CarViewModel.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import Foundation
import Combine
import Alamofire

class CarViewModel: ObservableObject {
    
    @Published var cars: [Car] = []
    @Published var isError: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
        getData()
    }
    
    func getData() {
        dataManager.getCars()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.isError = true
                } else {
                    self.cars = dataResponse.value!.cars
                }
            }.store(in: &cancellableSet)
    }
}
