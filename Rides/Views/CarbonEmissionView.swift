//
//  CarbonEmissionView.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//

import SwiftUI

struct CarbonEmissionView: View {
    let vehicle: Vehicle
    private let viewModel = CarbonEmissionViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Carbon Emissions")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Estimated emissions based on mileage and car type.")
            Text("Kilometrage: \(vehicle.kilometrage) km")
            Text("Car Type: \(vehicle.carType)")
            Text("Estimated Emissions: \(viewModel.calculateEmissions(for: vehicle.kilometrage)) units CO2")
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
        )
        .padding(.vertical, 20)
    }
}
