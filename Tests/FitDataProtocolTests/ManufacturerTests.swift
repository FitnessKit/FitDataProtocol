//
//  ManufacturerTests.swift
//  FitDataProtocolTests
//
//  Created by Kevin Hoogheem on 1/29/18.
//

import XCTest
@testable import FitDataProtocol

class CompanyIdentifierTests: XCTestCase {

    func testRegisterManufacturer() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        do {
            try Manufacturer.register(Manufacturer(id: 0xFFFE, name: "Not"))
        } catch  {
            XCTFail()

        }

        do {
            try Manufacturer.register(.development)
            XCTFail()

        } catch  {

        }

    }

    func testDups() {

        let x = Manufacturer.supportedManufacturers
        let duplicates = Array(Set(x.filter({ (i: Manufacturer) in x.filter({ $0.manufacturerID == i.manufacturerID }).count > 1})))

        if duplicates.count > 0 {
            for dup in duplicates {
                print("Dup: \(dup.manufacturerID) - \(dup.name)")
            }
            XCTFail("Multiple same IDs found")
        }

        print("Manufacturer Count: \(Manufacturer.supportedManufacturers.count)")

    }


    func testFindManufacturer() {

        if Manufacturer.company(id: 66) != Manufacturer.northPoleEngineering {
            XCTFail()
        }

        if Manufacturer.company(id: 1) == Manufacturer.northPoleEngineering {
            XCTFail()
        }

        if Manufacturer.company(id: 65534) != nil {
            XCTFail()
        }


    }

    static var allTests = [
        ("testRegisterManufacturer", testRegisterManufacturer),
        ("testDups", testDups),
        ("testFindManufacturer", testFindManufacturer),
        ]

}

