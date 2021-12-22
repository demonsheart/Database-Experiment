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
    @Published var chatListLoadingError: String = ""
    @Published var showAlert: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
        getCarList()
    }
    
    func getCarList() {
        dataManager.getCars()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    self.cars = dataResponse.value!.cars
                }
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: AFError ) {
        chatListLoadingError = "something error"
        self.showAlert = true
    }
}
