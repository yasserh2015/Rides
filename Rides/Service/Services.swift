//
//  Services.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//

import Moya

enum Services {
    case getRandomVehicles(count: Int)
}

extension Services: TargetType {
    var baseURL: URL {
        return URL(string: "https://random-data-api.com/api")!
    }
    
    var path: String {
        switch self {
        case .getRandomVehicles:
            return "/vehicle/random_vehicle"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getRandomVehicles(let count):
            return .requestParameters(parameters: ["size": count], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
