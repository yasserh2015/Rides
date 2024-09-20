//
//  ContentViewModelTests.swift
//  RidesTests
//
//  Created by yasser hamdan on 19/09/2024.
//

import XCTest
import Combine
@testable import Rides

final class ContentViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    
    func testValidInput() {
        
        //Given
        let sut = getSUT()
        var states = [ContentViewState]()
        let stateExpectations = expectation(description: "states")
        stateExpectations.expectedFulfillmentCount = 2
        
        //When
        sut.statePublisher.sink { state in
            states.append(state)
            stateExpectations.fulfill()
        }.store(in: &cancellables)

        sut.apply(input: .onPressButton(count: 15))
        
        //Then
        waitForExpectations(timeout: 5)
        XCTAssertEqual(states.count, 2)
        if case .update(let values) = states.last {
            XCTAssertFalse(values.showInputError)
        } else { XCTFail("last state should be update") }
    }
    
    func testInvalidInput() {
        
        //Given
        let sut = getSUT()
        var states = [ContentViewState]()
        let stateExpectations = expectation(description: "states")
        stateExpectations.expectedFulfillmentCount = 2
        
        //When
        sut.statePublisher.sink { state in
            states.append(state)
            stateExpectations.fulfill()
        }.store(in: &cancellables)

        sut.apply(input: .onPressButton(count: 1500))
        
        //Then
        waitForExpectations(timeout: 5)
        XCTAssertEqual(states.count, 2)
        if case .update(let values) = states.last {
            XCTAssertTrue(values.showInputError)
        } else { XCTFail("last state should be update") }
    }
}

extension ContentViewModelTests {
    private func getSUT() -> ContentViewModel {
        ContentViewModel(getvehiclesUseCase: GetVehiclesUseCaseMock())
    }
}
