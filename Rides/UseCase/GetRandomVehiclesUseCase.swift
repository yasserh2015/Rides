//
//  GetRandomVehiclesUseCase.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//

import Moya
import Combine

struct GetRandomVehiclesUseCase: GetVehiclesUseCase {
    private let provider = MoyaProvider<Services>()
    
    func getRandomVehicles(count: Int) -> AnyPublisher<[Vehicle], Error> {
        return Future<[Vehicle], Error> { promise in
            self.provider.request(.getRandomVehicles(count: count)) { result in
                switch result {
                case .success(let response):
                    do {
                        var vehicles = try JSONDecoder().decode([Vehicle].self, from: response.data)
                        vehicles.sort { $0.vin < $1.vin }
                        promise(.success(vehicles))
                    } catch let error {
                        promise(.failure(error))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
