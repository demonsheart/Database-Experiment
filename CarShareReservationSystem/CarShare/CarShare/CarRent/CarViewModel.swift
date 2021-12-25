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
    @Published var filterCar: [Car] = []
    
    @Published var minMaxCapacity: ClosedRange<Int> = 0...5
    @Published var curNum: Int = 0
    var max: Int = 0
    var min: Int = 0
    
    private var cancellableSet: Set<AnyCancellable> = []
    var curNumSubcription: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
        getData()
        $curNum.sink { self.searchCarForCapacity(num: $0) }
        .store(in: &curNumSubcription)
    }
    
    func getData() {
        dataManager.getCars()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.isError = true
                } else {
                    self.cars = dataResponse.value!.cars
                    self.filterCar = dataResponse.value!.cars
                    self.min = self.cars.min(by: { $0.capacity < $1.capacity })?.capacity ?? 0
                    self.max = self.cars.max(by: { $0.capacity < $1.capacity })?.capacity ?? 0
                    self.minMaxCapacity = self.min...self.max
                    self.curNum = self.min
                }
            }.store(in: &cancellableSet)
    }
    
    func searchCarForCapacity(num: Int) {
        filterCar = cars.filter { $0.capacity >= num }
    }
}
