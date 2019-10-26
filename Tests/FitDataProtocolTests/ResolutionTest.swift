//
//  ResolutionTest.swift
//  FitDataProtocolTests
//
//  Created by Kevin Hoogheem on 6/29/19.
//

import XCTest
@testable import FitDataProtocol

class ResolutionTest: XCTestCase {
    static var allTests = [
        ("testResolution", testResolution),
    ]
}

extension ResolutionTest {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testResolution() {
        let resolution = Resolution(scale: 2.0, offset: 500.0)
        
        let staringValue = 200.0
        
        let added = staringValue.resolution(.adding, resolution: resolution)
        let removed = added.resolution(.removing, resolution: resolution)

        if removed != staringValue {
            XCTFail()
        }
    }
}
