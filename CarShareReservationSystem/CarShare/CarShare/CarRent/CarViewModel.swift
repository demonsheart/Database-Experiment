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
    @Published var searchText: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    var subscription: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
        getData()
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.filterCar = self.cars
                    return nil
                }
                
                return string
            }) // prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [self] (searchField) in
                if let intValue = Int(searchField) {
                    self.searchCarForCapacity(num: intValue)
                }
            }.store(in: &subscription)
    }
    
    func getData() {
        dataManager.getCars()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.isError = true
                } else {
                    self.cars = dataResponse.value!.cars
                    self.filterCar = dataResponse.value!.cars
                }
            }.store(in: &cancellableSet)
    }
    
    func searchCarForCapacity(num: Int) {
        filterCar = cars.filter { $0.capacity >= num }
    }
}
