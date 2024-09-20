//
//  ContentViewModel.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//

import SwiftUI
import Combine

enum ContentViewState {
    case initializing
    case update(ContentViewModel.Values)
}

class ContentViewModel {
    
    private var vehicles = [Vehicle]()
    private var cancellables = Set<AnyCancellable>()
    private let getvehiclesUseCase: GetVehiclesUseCase
    private let stateSubject = CurrentValueSubject<ContentViewState, Never>(.initializing)
    
    init(getvehiclesUseCase: GetVehiclesUseCase) {
        self.getvehiclesUseCase = getvehiclesUseCase
    }
    
    var statePublisher: AnyPublisher<ContentViewState, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    class Values: ObservableObject {
        @Published var vehicles: [Vehicle]

        init(vehicles: [Vehicle]) {
            self.vehicles = vehicles
        }
    }
    
    enum Input {
        case onPressButton(count: Int)
        case onSortOptionSelection(sortOption: SortOption)
    }
    
    func apply(input: Input) {
        switch(input) {
        case .onPressButton(let count):
            getVehicles(count: count)
        case .onSortOptionSelection(let sortOption):
            sortVehicles(by: sortOption)
        }
    }
    
    private func getVehicles(count: Int) {
        getvehiclesUseCase.getRandomVehicles(count: count)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            } receiveValue: { vehicles in
                if !vehicles.isEmpty {
                    self.vehicles = vehicles
                    self.updateView()
                }
            }.store(in: &cancellables)
    }
    
    private func sortVehicles(by sortOption: SortOption) {
        switch sortOption {
        case .vin:
            vehicles.sort { $0.vin < $1.vin }
        case .carType:
            vehicles.sort { $0.carType < $1.carType }
        }
        updateView()
    }
    
    private func updateView() {
        let values = ContentViewModel.Values(vehicles: vehicles)
        stateSubject.send(.update(values))
    }
}
