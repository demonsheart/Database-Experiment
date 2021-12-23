//
//  ProbationViewModel.swift
//  CarShare
//
//  Created by herongjin on 2021/12/23.
//

import Foundation
import Combine
import Alamofire

class ProbationViewModel: ObservableObject {
    @Published var cus: [ProbationCus] = []
    @Published var isError: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
        getData()
    }
    
    func getData() {
        dataManager.getProbationList()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.isError = true
                } else {
                    self.cus = dataResponse.value!.cus
                }
            }.store(in: &cancellableSet)
    }
}
