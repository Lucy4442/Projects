//
//  UnitTestingViewModel_Tests.swift
//  UnitTesting_Tests
//
//  Created by mac on 29/04/24.
//

import XCTest
@testable import UnitTesting
//Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior

//Testing Structure : Given, When, Then

class UnitTestingViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ViewModel_isPremium_shouldbeTrue() {
        //Given
        let userIsPremium : Bool = true
        
        //When
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssert(vm.isPremium)
    }

}
