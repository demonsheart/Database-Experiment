//
//  MyRentalsViewModel.swift
//  CarShare
//
//  Created by aicoin on 2021/12/27.
//

import Foundation
import Combine

class MyRentalsViewModel: ObservableObject {
    
    @Published var rentals: [FullRentalModel] = []
    @Published var isError: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
        getData()
    }
    
    func getData() {
        guard let cusid = UserStateModel.shared.user?.data.cusID else { return }
        dataManager.getRentals(cusid: cusid)
            .sink { (dataResponse) in
                if let v = dataResponse.value {
                    self.rentals = v.data
                } else {
                    self.isError = true
                }
            }.store(in: &cancellableSet)
    }
}
