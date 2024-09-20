//
//  Vehicle.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//

struct Vehicle: Codable, Identifiable {
    let id: Int
    let uid: String
    let vin: String
    let makeAndModel: String
    let color: String
    let transmission: String
    let driveType: String
    let fuelType: String
    let carType: String
    let carOptions: [String]
    let specs: [String]
    let doors: Int
    let mileage: Int
    let kilometrage: Int
    let licensePlate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case vin
        case makeAndModel = "make_and_model"
        case color
        case transmission
        case driveType = "drive_type"
        case fuelType = "fuel_type"
        case carType = "car_type"
        case carOptions = "car_options"
        case specs
        case doors
        case mileage
        case kilometrage
        case licensePlate = "license_plate"
    }
}


