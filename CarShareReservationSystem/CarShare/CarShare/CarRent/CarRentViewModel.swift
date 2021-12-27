//
//  CarRentViewModel.swift
//  CarShare
//
//  Created by aicoin on 2021/12/27.
//

import Foundation
import Combine

//{
//    "rental_date": "2010-02-03",
//    "pick_up_time": "2010-02-17 19:00:00",
//    "drop_off_time": "2010-02-17 19:30:00",
//    "cus_id": "M-62",
//    "car_id": 101,
//    "loc_id": 60
//}

class CarRentViewModel: ObservableObject {
    
    let car: Car
    var locs: [Loc] = []
    
    var rentalDate = Date()
    @Published var pickDate = Date()
    @Published var dropDate = Date()
    @Published var pickerAddress = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var cancellableSet2: Set<AnyCancellable> = []
    private var cancellableSet3: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    var locStrs: [String] {
        return locs.map { loc in
            loc.streetAddress
        }
    }
    
    var selectedLocId: Int {
        if let i = locs.firstIndex(where: { $0.streetAddress == pickerAddress }) {
            return locs[i].locID
        } else {
            return -1
        }
    }
    
    // "yyyy-MM-dd HH:mm:ss"
    var rentalDateStr: String {
        return rentalDate.getFormattedDate(format: "yyyy-MM-dd")
    }
    
    var pickDateStr: String {
        return pickDate.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
    }
    
    var dropDateStr: String {
        return dropDate.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
    }
    
    var params: RentModel? {
        guard let cusId = UserStateModel.shared.user?.data.cusID else { return nil }
        if selectedLocId == -1 {
            return nil
        }
        return RentModel(rentalDate: rentalDateStr, pickUpTime: pickDateStr, dropOffTime: dropDateStr, cusID: cusId, carID: car.carID, locID: selectedLocId)
    }
    
    var validatedAll: AnyPublisher<Bool, Never> {
        validatePickDate.combineLatest(validateDropDate) { b1, b2 in
            return b1 && b2
        }
        .eraseToAnyPublisher()
    }
    
    var validatePickDate: AnyPublisher<Bool, Never> {
        return $pickDate
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { _ in
                return Future { promise in
                    self.dateAvailable() { available in
                        promise(.success(available))
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    var validateDropDate: AnyPublisher<Bool, Never> {
        return $dropDate
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { _ in
                return Future { promise in
                    self.dateAvailable() { available in
                        promise(.success(available))
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    
    
    func dateAvailable(completion: @escaping (Bool) -> ()) -> () {
        guard let params = params else {
            return
        }
        
        self.dataManager.validateRent(model: params)
            .sink { data in
                if let value = data.value {
                    print(value.error)
                    completion(value.success)
                } else {
                    completion(false)
                }
            }.store(in: &cancellableSet3)
    }
    
    init(dataManager: ServiceProtocol = Service.shared, selectedCar: Car) {
        self.car = selectedCar
        self.dataManager = dataManager
        getLocs()
    }
    
    func getLocs() {
        dataManager.getLocs()
            .sink { (dataResponse) in
                if let v = dataResponse.value {
                    self.locs = v.locs
                }
            }.store(in: &cancellableSet)
    }
    
    func rentCar(callback:@escaping ((Bool)->Void)) {
        if let params = params {
            dataManager.rentCar(model: params)
                .sink { (dataResponse) in
                    if let v = dataResponse.value {
                        print(v.error)
                        callback(v.success)
                    }
                }.store(in: &cancellableSet2)
        }
    }
}
