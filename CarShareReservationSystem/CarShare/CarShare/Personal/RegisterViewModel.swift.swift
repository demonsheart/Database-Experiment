//
//  RegisterViewModel.swift.swift
//  CarShare
//
//  Created by aicoin on 2021/12/26.
//

import Foundation
import Combine
import Alamofire

struct IDModel: Codable {
    let cusID: String
    
    enum CodingKeys: String, CodingKey {
        case cusID = "cus_id"
    }
}

class RegisterViewModel: ObservableObject {
    
    @Published var account: String = ""
    @Published var password: String = ""
    @Published var password2: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var hometown: String = ""
    @Published var cellPhone: String = ""
    @Published var telePhone: String = ""
    @Published var email: String = ""
    @Published var credit: String = ""
    @Published var license: String = ""
    @Published var state: String = ""
    @Published var date = Date()
    @Published var tickers: String = ""
    @Published var isStudent: Int = 0
    
    var formatDate: String {
        return date.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
    }
    
    let isStudents: [Int] = [0, 1]
    let states = ["GA", "NY", "PA"]
    
    let dataManager = Service.shared
    private var cancellableSet: Set<AnyCancellable> = []
    private var cancellableSet2: Set<AnyCancellable> = []
    
    var validatedPassword: AnyPublisher<String?, Never> {
        $password.combineLatest($password2) { p1, p2 in
            guard p1 == p2, p1.count > 6 else {
                return nil
            }
            return p1
        }
        .eraseToAnyPublisher()
    }
    
    var validatedUsername: AnyPublisher<String?, Never> {
        return $account
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { id in
                return Future { promise in
                    self.idAvailable(id) { available in
                        promise(.success(available ? id : nil))
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    var validatedCredentials: AnyPublisher<(String, String)?, Never> {
        validatedUsername.combineLatest(validatedPassword) { username, password in
            guard let uname = username, let pwd = password else { return nil }
            return (uname, pwd)
        }
        .eraseToAnyPublisher()
    }
    
    func idAvailable(_ id: String, completion: @escaping (Bool) -> ()) -> () {
        dataManager.validateID(params: IDModel(cusID: id))
            .sink { data in
                if let value = data.value, value.success {
                    completion(true)
                } else {
                    completion(false)
                }
            }.store(in: &cancellableSet2)
    }
    
    func register(callback:@escaping ((Bool)->Void)) {
        let user = User(cusID: account, password: password, lastName: lastName, firstName: firstName, hometown: hometown, cellPhone: cellPhone,telephone: telePhone , email: email, creditCard: credit, isStudent: isStudent, license: license, state: state, expireDate: formatDate, tickets: Int(tickers) ?? 0)
        dataManager.registor(params: user)
            .sink { (dataResponse) in
                if let value = dataResponse.value {
                    callback(value.success)
                }
            }.store(in: &cancellableSet)
    }
}

