//
//  GetVehiclesUseCaseMock.swift
//  RidesTests
//
//  Created by yasser hamdan on 19/09/2024.
//

import Combine
@testable import Rides

class GetVehiclesUseCaseMock: GetVehiclesUseCase {
    
    func getRandomVehicles(count: Int) -> AnyPublisher<[Vehicle], Error> {
        let vehicles = [
            Vehicle(id: 1, uid: "1", vin: "1HGCM82633A123456", makeAndModel: "Honda Accord", color: "Blue", transmission: "Automatic", driveType: "FWD", fuelType: "Gasoline", carType: "Sedan", carOptions: ["Air Conditioning", "Power Windows"], specs: ["Dual-zone automatic climate control"], doors: 4, mileage: 35000, kilometrage: 56327, licensePlate: "XYZ-1234"),
            Vehicle(id: 2, uid: "2", vin: "JHMCM82633C234567", makeAndModel: "Toyota Camry", color: "Red", transmission: "Manual", driveType: "AWD", fuelType: "Hybrid", carType: "SUV", carOptions: ["Navigation System", "Leather Seats"], specs: ["Adaptive cruise control"], doors: 4, mileage: 50000, kilometrage: 80467, licensePlate: "ABC-5678"),
            Vehicle(id: 3, uid: "3", vin: "5TDBY5G18HS345678", makeAndModel: "Ford Mustang", color: "Yellow", transmission: "Automatic", driveType: "RWD", fuelType: "Electric", carType: "Coupe", carOptions: ["Bluetooth", "Heated Seats"], specs: ["Sport-tuned suspension"], doors: 2, mileage: 15000, kilometrage: 24140, licensePlate: "FORD-789")
        ]
        
        return Just(vehicles)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

