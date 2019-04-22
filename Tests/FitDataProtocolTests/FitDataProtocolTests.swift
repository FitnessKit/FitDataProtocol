import XCTest
@testable import FitDataProtocol
import FitnessUnits
import AntMessageProtocol

extension Data {
    /// Returns a `0x` prefixed, space-separated, hex-encoded string for this `Data`.
    public var hexDebug: String {
        return "" + map { String(format: "0x%02X,", $0) }.joined(separator: " ")
    }
}

class FitDataProtocolTests: XCTestCase {
    static var allTests = [
        ("testExampleEncodeDecode", testExampleEncodeDecode),
        ("testGoodProtocolBatFitFile", testGoodProtocolBatFitFile),
        ("testBadProtocolFitFile", testBadProtocolFitFile),
        ("testBadProtocolBadFitFile", testBadProtocolBadFitFile),
        ("testHeaderSizeWrong", testHeaderSizeWrong),
        ("testSparseData", testSparseData)
    ]
}

extension FitDataProtocolTests {
        
    func testGoodProtocolBatFitFile() {
        let fileData = Data([0x0E, 0x20, 0x20, 0x08, 0x4D, 0x00, 0x00, 0x00, 0x2D, 0x46, 0x49, 0x54, 0x3F, 0x86, 0x40, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x01, 0x00, 0x01, 0x02, 0x84, 0x02, 0x02, 0x84, 0x03, 0x04, 0x8C, 0x04, 0x04, 0x86, 0x00, 0x04, 0x42, 0x00, 0x16, 0x00, 0x16, 0x00, 0x00, 0x00, 0x93, 0x7D, 0xFA, 0x36, 0x40, 0x00, 0x00, 0x22, 0x00, 0x04, 0xFD, 0x04, 0x86, 0x00, 0x04, 0x86, 0x01, 0x02, 0x84, 0x02, 0x01, 0x00, 0x00, 0x93, 0x7D, 0xFA, 0x36, 0x40, 0x0D, 0x03, 0x00, 0x16, 0x00, 0x01, 0x00, 0x93, 0x7D, 0xFA, 0x36, 0x40, 0x0D, 0x03, 0x00, 0x16, 0x00, 0x01, 0xC6, 0xDA])
        
        do {
            var decoder = FitFileDecoder(crcCheckingStrategy: .throws)
            
            try decoder.decode(data: fileData, messages: FitFileDecoder.defaultMessages, decoded: { (message) in
                XCTFail("Not a .FIT File")
            })

        } catch let error as FitDecodingError {
            if error != .nonFitFile {
                XCTFail("Error should have been nonFitFile")
            }
        } catch {
            XCTFail("Error should have been nonFitFile")
        }

    }
    
    func testBadProtocolFitFile() {
        /// Bad Protocol, but contains .FIT
        let fileData = Data([0x0E, 0xFF, 0x20, 0x08, 0x4D, 0x00, 0x00, 0x00, 0x2E, 0x46, 0x49, 0x54, 0x3F, 0x86, 0x40, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x01, 0x00, 0x01, 0x02, 0x84, 0x02, 0x02, 0x84, 0x03, 0x04, 0x8C, 0x04, 0x04, 0x86, 0x00, 0x04, 0x42, 0x00, 0x16, 0x00, 0x16, 0x00, 0x00, 0x00, 0x93, 0x7D, 0xFA, 0x36, 0x40, 0x00, 0x00, 0x22, 0x00, 0x04, 0xFD, 0x04, 0x86, 0x00, 0x04, 0x86, 0x01, 0x02, 0x84, 0x02, 0x01, 0x00, 0x00, 0x93, 0x7D, 0xFA, 0x36, 0x40, 0x0D, 0x03, 0x00, 0x16, 0x00, 0x01, 0x00, 0x93, 0x7D, 0xFA, 0x36, 0x40, 0x0D, 0x03, 0x00, 0x16, 0x00, 0x01, 0xC6, 0xDA])
        
        do {
            var decoder = FitFileDecoder(crcCheckingStrategy: .throws)
            
            try decoder.decode(data: fileData, messages: FitFileDecoder.defaultMessages, decoded: { (message) in
                XCTFail("Not a .FIT File")
            })
            
        } catch let error as FitDecodingError {
            if error != .protocolVersionNotSupported {
                XCTFail("Error should have been protocolVersionNotSupported")
            }
        } catch {
            XCTFail("Error should have been protocolVersionNotSupported")
        }
    }
    
    func testBadProtocolBadFitFile() {
        /// Bad Protocol, does not contains .FIT
        let fileData = Data([0x0E, 0xFF, 0x20, 0x08, 0x4D, 0x00, 0x00, 0x00, 0x2C, 0x46, 0x49, 0x54, 0x3F, 0x86, 0x40, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x01, 0x00, 0x01, 0x02, 0x84, 0x02, 0x02, 0x84, 0x03, 0x04, 0x8C, 0x04, 0x04, 0x86, 0x00, 0x04, 0x42, 0x00, 0x16, 0x00, 0x16, 0x00, 0x00, 0x00, 0x93, 0x7D, 0xFA, 0x36, 0x40, 0x00, 0x00, 0x22, 0x00, 0x04, 0xFD, 0x04, 0x86, 0x00, 0x04, 0x86, 0x01, 0x02, 0x84, 0x02, 0x01, 0x00, 0x00, 0x93, 0x7D, 0xFA, 0x36, 0x40, 0x0D, 0x03, 0x00, 0x16, 0x00, 0x01, 0x00, 0x93, 0x7D, 0xFA, 0x36, 0x40, 0x0D, 0x03, 0x00, 0x16, 0x00, 0x01, 0xC6, 0xDA])
        
        do {
            var decoder = FitFileDecoder(crcCheckingStrategy: .throws)
            
            try decoder.decode(data: fileData, messages: FitFileDecoder.defaultMessages, decoded: { (message) in
                XCTFail("Not a .FIT File")
            })
            
        } catch let error as FitDecodingError {
            if error != .nonFitFile {
                XCTFail("Error should have been nonFitFile")
            }
        } catch {
            XCTFail("Error should have been nonFitFile")
        }

    }

    func testHeaderSizeWrong() {
        let fileData = Data([0x0E, 0xFF, 0x20])
        
        do {
            var decoder = FitFileDecoder(crcCheckingStrategy: .throws)
            
            try decoder.decode(data: fileData, messages: FitFileDecoder.defaultMessages, decoded: { (message) in
                XCTFail("Not a .FIT File")
            })
            
        } catch let error as FitDecodingError {
            if error != .nonFitFile {
                XCTFail("Error should have been nonFitFile")
            }
        } catch {
            XCTFail("Error should have been nonFitFile")
        }
    }

    func testSparseData() {
        /// Similar to the header wrong size.  But Here it should get past the first check
        /// for the header as it is not larger then total dat
        let fileData = Data([0x01, 0xFF, 0x20, 0x08, 0x4D])
        
        do {
            var decoder = FitFileDecoder(crcCheckingStrategy: .throws)
            
            try decoder.decode(data: fileData, messages: FitFileDecoder.defaultMessages, decoded: { (message) in
                XCTFail("Not a .FIT File")
            })
            
        } catch let error as FitDecodingError {
            if error != .nonFitFile {
                XCTFail("Error should have been nonFitFile")
            }
        } catch {
            XCTFail("Error should have been nonFitFile")
        }
    }

    func testExampleEncodeDecode() {
        
        let fTime = FitTime(date: Date())
        
        let timer = Measurement(value: 200.0, unit: UnitDuration.seconds)
        
        let act = ActivityMessage(timeStamp: fTime,
                                  totalTimerTime: timer,
                                  localTimeStamp: nil,
                                  numberOfSessions: ValidatedBinaryInteger(value: UInt16(22), valid: true),
                                  activity: Activity.multisport,
                                  event: nil,
                                  eventType: nil,
                                  eventGroup: nil)
        
        print(act.messageName)
        
        let fiel = FileIdMessage(deviceSerialNumber: ValidatedBinaryInteger(value: UInt32(22), valid: true),
                                 fileCreationDate: fTime,
                                 manufacturer: Manufacturer.northPoleEngineering,
                                 product: ValidatedBinaryInteger(value: UInt16(22), valid: true),
                                 fileNumber: nil,
                                 fileType: FileType.activity,
                                 productName: "sdf--22")
        
        let encoder = FitFileEncoder(dataValidityStrategy: .none)
        
        var encodedData: Data!
        
        let result = encoder.encode(fildIdMessage: fiel, messages: [act, act])
        switch result {
        case .success(let data):
            print(data as NSData)
            encodedData = data
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }

        
        do {
            var decoder = FitFileDecoder(crcCheckingStrategy: .throws)
            
            try decoder.decode(data: encodedData, messages: FitFileDecoder.defaultMessages, decoded: { (message) in
                
                if let fileId = message as? FileIdMessage {
                    if fileId.manufacturer != Manufacturer.northPoleEngineering {
                        XCTFail()
                    }
                    if fileId.product?.value != UInt16(22) {
                        XCTFail()
                    }
                    if fileId.productName != "sdf--22" {
                        XCTFail()
                    }


                }
                print(message)
            })
            
        } catch  {
            print(error)
        }
        
        
    }

}
