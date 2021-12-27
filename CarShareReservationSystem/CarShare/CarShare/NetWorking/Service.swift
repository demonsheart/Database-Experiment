//
//  Service.swift
//  CarShare
//
//  Created by herongjin on 2021/12/22.
//

import Foundation
import Combine
import Alamofire

struct CommonNetModel: Codable {
    let success: Bool
    let error: String
}

protocol ServiceProtocol {
    func getCars() -> AnyPublisher<DataResponse<CarListModel, AFError>, Never>
    func getProbationList() -> AnyPublisher<DataResponse<ProbationListModel, AFError>, Never>
    func getPopularLocsList() -> AnyPublisher<DataResponse<PopularLocsListModel, AFError>, Never>
    func getRentalTrendsList() -> AnyPublisher<DataResponse<RentalTrendsListModel, AFError>, Never>
    func login(params: LoginModel) -> AnyPublisher<DataResponse<UserModel, AFError>, Never>
    func registor(params: User) -> AnyPublisher<DataResponse<CommonNetModel, AFError>, Never>
    func validateID(params: IDModel) -> AnyPublisher<DataResponse<CommonNetModel, AFError>, Never>
    func getLocs() -> AnyPublisher<DataResponse<LocsListModel, AFError>, Never>
    func rentCar(model: RentModel) -> AnyPublisher<DataResponse<CommonNetModel, AFError>, Never>
    func validateRent(model: RentModel) -> AnyPublisher<DataResponse<CommonNetModel, AFError>, Never>
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
        return AF.request(Service.domain + "cars", method: .post, headers: Service.defaultHeaders)
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
    
    func getProbationList() -> AnyPublisher<DataResponse<ProbationListModel, AFError>, Never> {
        
        // parameters: params, encoder: JSONParameterEncoder.default
        return AF.request(Service.domain + "probation", method: .post, headers: Service.defaultHeaders)
            .validate()
            .publishDecodable(type: ProbationListModel.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getPopularLocsList() -> AnyPublisher<DataResponse<PopularLocsListModel, AFError>, Never> {
        
        // parameters: params, encoder: JSONParameterEncoder.default
        return AF.request(Service.domain + "popular-locations", method: .post, headers: Service.defaultHeaders)
            .validate()
            .publishDecodable(type: PopularLocsListModel.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getRentalTrendsList() -> AnyPublisher<DataResponse<RentalTrendsListModel, AFError>, Never> {
        
        // parameters: params, encoder: JSONParameterEncoder.default
        return AF.request(Service.domain + "rental-trends", method: .post, headers: Service.defaultHeaders)
            .validate()
            .publishDecodable(type: RentalTrendsListModel.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func login(params: LoginModel) -> AnyPublisher<DataResponse<UserModel, AFError>, Never> {
        
        // parameters: params, encoder: JSONParameterEncoder.default
        return AF.request(Service.domain + "login", method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: Service.defaultHeaders)
            .validate()
            .publishDecodable(type: UserModel.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func registor(params: User) -> AnyPublisher<DataResponse<CommonNetModel, AFError>, Never> {
        return AF.request(Service.domain + "register", method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: Service.defaultHeaders)
            .validate()
            .publishDecodable(type: CommonNetModel.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func validateID(params: IDModel) -> AnyPublisher<DataResponse<CommonNetModel, AFError>, Never> {
        return AF.request(Service.domain + "is-id-register", method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: Service.defaultHeaders)
            .validate()
            .publishDecodable(type: CommonNetModel.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getLocs() -> AnyPublisher<DataResponse<LocsListModel, AFError>, Never> {
        return AF.request(Service.domain + "center-loc", method: .get, headers: Service.defaultHeaders)
            .validate()
            .publishDecodable(type: LocsListModel.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func rentCar(model: RentModel) -> AnyPublisher<DataResponse<CommonNetModel, AFError>, Never> {
        return AF.request(Service.domain + "rent-car", method: .post, parameters: model, encoder: JSONParameterEncoder.default, headers: Service.defaultHeaders)
            .validate()
            .publishDecodable(type: CommonNetModel.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    func validateRent(model: RentModel) -> AnyPublisher<DataResponse<CommonNetModel, AFError>, Never> {
        return AF.request(Service.domain + "validate-rent", method: .post, parameters: model, encoder: JSONParameterEncoder.default, headers: Service.defaultHeaders)
            .validate()
            .publishDecodable(type: CommonNetModel.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
