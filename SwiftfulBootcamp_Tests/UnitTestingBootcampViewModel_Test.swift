//
//  UnitTestingBootcampViewModel_Test.swift
//  SwiftfulBootcamp_Tests
//
//  Created by Akbarshah Jumanazarov on 12/14/24.
//

import XCTest
@testable import SwiftfulBootcamp

final class UnitTestingBootcampViewModel_Test: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        XCTAssertTrue(vm.dataArrray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shoulAddItems() {
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        vm.addItem(item: "Hello")
        XCTAssertTrue(!vm.dataArrray.isEmpty)
    }
}
