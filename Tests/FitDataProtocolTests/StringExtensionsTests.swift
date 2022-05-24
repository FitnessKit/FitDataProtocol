import Foundation
import XCTest
@testable import FitDataProtocol

final class StringExtensionsTests: XCTestCase {
    func testDecodingAMessageString() throws {
        // "Keeper\0\u{02}\0\0\0 \0\u{16}\0\0ÿ\0\0\0\0\u{05}ÿÿÿÿHit lap when finished.\0\0"
        let data: [UInt8] = [
            75, 101, 101, 112, 101, 114, 0, 2, 0, 0, 0, 32, 0, 22, 0, 0, 255, 0, 0, 0, 0, 5, 255, 255, 255, 255, 72, 105, 116, 32, 108, 97, 112, 32, 119, 104, 101, 110, 32, 102, 105, 110, 105, 115, 104, 101, 100, 46, 0, 0
        ]

        XCTAssertEqual("Keeper", String.decode(type: String.self, data: Data(data), base: .init(type: .string, resolution: Resolution(scale: 1, offset: 0)), arch: .little))

        XCTAssertEqual("Laufen", String.decode(type: String.self, data: Data( Array("Laufen\0\0n\0\0\u{04}Èî»p\0\0\0\u{04})Ä\u{13}\u{08}".utf8)), base: .init(type: .string, resolution: Resolution(scale: 1, offset: 0)), arch: .little))
    }
}
