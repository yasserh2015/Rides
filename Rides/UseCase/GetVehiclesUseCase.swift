//
//  GetVehiclesUseCase.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//
import Combine

protocol GetVehiclesUseCase {
    func getRandomVehicles(count: Int) -> AnyPublisher<[Vehicle], Error>
}
