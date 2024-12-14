//
//  UnitTestingBootcampViewModel_Test.swift
//  SwiftfulBootcamp_Tests
//
//  Created by Akbarshah Jumanazarov on 12/14/24.
//

import XCTest
import Combine
@testable import SwiftfulBootcamp

final class UnitTestingBootcampViewModel_Test: XCTestCase {
    
    var vm: UnitTestingBootcampViewModel?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<100 {
            let value: Bool = Bool.random()
            let vm = UnitTestingBootcampViewModel(isPremium: value)
            XCTAssertEqual(vm.isPremium, value)
        }
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldbeEmpty() {
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shoulAddItems() {
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        vm.addItem(item: "Hello")
        XCTAssertTrue(!vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_downloadWithEscping_shouldReturnItems() {
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        let expectation = XCTestExpectation(description: "Should return items after 2 secs")
        
        vm.$dataArray
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithEscaping() //this func is async
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_downloadWithCombine_shouldReturnItems() {
        guard let vm = vm else {
            XCTFail()
            return
        }
                
        let expectation = XCTestExpectation(description: "Should return items after 2 secs")
        
        vm.$dataArray
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine() //this func is async
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
}
