//
//  DependencyContainer.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//

import Swinject
import SwinjectAutoregistration
import Combine

class DependencyContainer: ObservableObject {
    private let container: Container
    
    init() {
        self.container = Container()
        initialize()
    }
    
    func initialize() {
        registerContentView(container)
        registerUseCases(container)
    }
    
    private func registerContentView(_ container: Container) {
        container.register(ContentViewModel.self) { resolver in
            let getVehiclesUseCase = resolver ~> GetVehiclesUseCase.self
            return ContentViewModel(getvehiclesUseCase: getVehiclesUseCase)
        }
        container.register(ContentView.self) { resolver in
            let viewModel = resolver ~> (ContentViewModel.self)
            return ContentView(viewModel: viewModel)
        }
    }
    
    func resolveContentView() -> ContentView {
        guard let contentView = container.resolve(ContentView.self) else {
            fatalError("ContentView registration is missing")
        }
        return contentView
    }
    
    private func registerUseCases(_ container: Container) {
        container.autoregister(GetVehiclesUseCase.self, initializer: GetRandomVehiclesUseCase.init)
    }
}
