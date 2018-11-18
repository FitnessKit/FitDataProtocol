import XCTest
@testable import FitDataProtocol

class FitDataProtocolTests: XCTestCase {

    func testExample() {

        let rc = RecordHeader(localMessageType: 14, isDataMessage: true, developerData: false)

        print(rc.normalHeader)
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
