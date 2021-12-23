//
//  RentalTrendsViewModel.swift
//  CarShare
//
//  Created by herongjin on 2021/12/23.
//

import Foundation
import Combine
import Alamofire

class RentalTrendsViewModel: ObservableObject {
    @Published var trends: [Trend] = []
    @Published var isError: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    var studentCount: Int {
        return trends.filter { $0.isStudent == 1 }.count
    }
    
    var notStudentCount: Int {
        return trends.filter { $0.isStudent == 0 }.count
    }
    
    var studentBarChartDataSet: [ChartData] {
        return trends.filter { $0.isStudent == 1 }.map { ChartData(label: $0.make + " " + $0.model, value: Double($0.numberOfTimesRented)) }
    }
    
    var notStudentBarChartDataSet: [ChartData] {
        return trends.filter { $0.isStudent == 0 }.map { ChartData(label: $0.make + " " + $0.model, value: Double($0.numberOfTimesRented)) }
    }
    
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
        getData()
    }
    
    func getData() {
        dataManager.getRentalTrendsList()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.isError = true
                } else {
                    self.trends = dataResponse.value!.trends
                }
            }.store(in: &cancellableSet)
    }
}
