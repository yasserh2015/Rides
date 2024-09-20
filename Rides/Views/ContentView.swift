//
//  ContentView.swift
//  Rides
//
//  Created by yasser hamdan on 19/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentState: ContentViewState = .initializing
    @State private var vehicleCount: String = ""
    @State private var selectedSortOption: SortOption = .vin
    private var viewModel : ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Enter vehicle count", text: $vehicleCount)
                    .padding()
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    if let count = Int(vehicleCount) {
                        viewModel.apply(input: .onPressButton(count: count))
                    }
                }) {
                    Text("Load Vehicles List")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal)
                
                if case .update(let values) = currentState {
                    createListView(values: values)
                }
            }
            .navigationTitle("Vehicles list")
            .onReceive(viewModel.statePublisher) { state in
                currentState = state
            }
        }
    }
    
    private func createListView(values: ContentViewModel.Values) -> some View {
        VStack {
            Picker("Sort by", selection: $selectedSortOption) {
                Text("VIN").tag(SortOption.vin)
                Text("Car Type").tag(SortOption.carType)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedSortOption) { newValue in
                viewModel.apply(input: .onSortOptionSelection(sortOption: newValue))
            }
            
            List(values.vehicles, id: \.id) { vehicle in
                VStack(alignment: .leading) {
                    NavigationLink(destination: VehicleDetailView(vehicle: vehicle)) {
                        VStack(alignment: .leading) {
                            Text("Make and Model: \(vehicle.makeAndModel)")
                            Text("Vin: \(vehicle.vin)")
                        }
                    }
                    
                }
            }
        }
    }
}

