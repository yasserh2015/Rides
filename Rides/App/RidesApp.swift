//
//  RidesApp.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//

import SwiftUI

@main
struct RidesApp: App {
    @StateObject private var globalDependencyContainer = DependencyContainer()
    var body: some Scene {
        WindowGroup {
            globalDependencyContainer.resolveContentView()
                .environmentObject(globalDependencyContainer)
        }
    }
}
