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
        @Published var showInputError: Bool

        init(vehicles: [Vehicle],
             showInputError: Bool) {
            self.vehicles = vehicles
            self.showInputError = showInputError
        }
    }
    
    enum Input {
        case onPressButton(count: Int)
        case onSortOptionSelection(sortOption: SortOption)
    }
    
    func apply(input: Input) {
        switch(input) {
        case .onPressButton(let count):
            validateInput(count: count)
        case .onSortOptionSelection(let sortOption):
            sortVehicles(by: sortOption)
        }
    }
    
    private func validateInput(count: Int) {
        if count >= 1 && count <= 100 {
            getVehicles(count: count)
        } else {
            updateView(showError: true)
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
                self.vehicles = vehicles
                self.updateView(showError: false)
            }.store(in: &cancellables)
    }
    
    private func sortVehicles(by sortOption: SortOption) {
        switch sortOption {
        case .vin:
            vehicles.sort { $0.vin < $1.vin }
        case .carType:
            vehicles.sort { $0.carType < $1.carType }
        }
        updateView(showError: false)
    }
    
    
    private func updateView(showError: Bool) {
        let values = ContentViewModel.Values(vehicles: vehicles,
                                             showInputError: showError)
        stateSubject.send(.update(values))
    }
}
