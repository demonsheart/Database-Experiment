//
//  Service.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import Foundation
import Combine
import Alamofire

protocol ServiceProtocol {
    func getCars() -> AnyPublisher<DataResponse<CarListModel, AFError>, Never>
}


class Service {
    static let shared: ServiceProtocol = Service()
    static let defaultHeaders: HTTPHeaders = [
        "Content-Type": "application/json",
        "User-Agent": "HRJ",
    ]
    static let domain = "http://127.0.0.1:60036/"
    private init() { }
}

extension Service: ServiceProtocol {
    func getCars() -> AnyPublisher<DataResponse<CarListModel, AFError>, Never> {
        
        // parameters: params, encoder: JSONParameterEncoder.default
        return AF.request(Service.domain + "cars", method: .get, headers: Service.defaultHeaders)
            .validate()
            .publishDecodable(type: CarListModel.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
