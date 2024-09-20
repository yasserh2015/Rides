//
//  VehicleDetailsScrollableView.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//

import SwiftUI

struct VehicleDetailsScrollableView: View {
    let vehicle: Vehicle
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    VehicleDetailView(vehicle: vehicle)
                        .frame(width: proxy.size.width - 40)
                    CarbonEmissionView(vehicle: vehicle)
                        .frame(width: proxy.size.width - 40)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}
