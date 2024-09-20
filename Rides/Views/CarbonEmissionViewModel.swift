//
//  CarbonEmissionViewModel.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//

class CarbonEmissionViewModel {
    func calculateEmissions(for kilometrage: Int) -> Double {
        if kilometrage <= 5000 {
            return Double(kilometrage) * 1.0
        } else {
            let initialEmissions = 5000 * 1.0
            let additionalEmissions = Double(kilometrage - 5000) * 1.5
            return initialEmissions + additionalEmissions
        }
    }
}
