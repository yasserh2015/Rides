//
//  VehicleDetailView.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//

import SwiftUI

struct VehicleDetailView: View {
    let vehicle: Vehicle
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(vehicle.makeAndModel)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(vehicle.carType)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Image(systemName: "car.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue.opacity(0.1))
                )
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Vehicle Identification Number")
                        .font(.headline)
                    
                    Text(vehicle.vin)
                        .font(.body)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.1))
                        )
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Color")
                        .font(.headline)
                    
                    Text(vehicle.color)
                        .font(.body)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.1))
                        )
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Vehicle Details")
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
        )
        .padding(.vertical, 20)
    }
}
