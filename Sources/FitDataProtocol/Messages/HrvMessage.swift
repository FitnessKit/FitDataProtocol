//
//  HrvMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/3/18.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import DataDecoder

/// FIT HRV Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class HrvMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 78 }

    /// Heart Rate Variability
    ///
    /// Time between beats
    private(set) public var hrv: [Measurement<UnitDuration>]?

    public required init() {}

    internal init(_ hrv: [Measurement<UnitDuration>]?) {
        self.hrv = hrv
    }

    public init(hrv: [Measurement<UnitDuration>]) {
        self.hrv = hrv
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> HrvMessage  {

        var hrv: [Measurement<UnitDuration>]?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("HrvMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .time:
                    let timeData = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                    var localDecoder = DecodeData()

                    var seconds = arch == .little ? localDecoder.decodeUInt16(timeData).littleEndian : localDecoder.decodeUInt16(timeData).bigEndian

                    while seconds != 0 {
                        /// 1000 * s + 0, Time between beats
                        let value = seconds.resolution(1 / 1000)
                        let interval = Measurement(value: value, unit: UnitDuration.seconds)

                        if hrv == nil {
                            hrv = [Measurement<UnitDuration>]()
                        }
                        hrv?.append(interval)

                        seconds = arch == .little ? localDecoder.decodeUInt16(timeData).littleEndian : localDecoder.decodeUInt16(timeData).bigEndian
                    }

                }
            }
        }

        return HrvMessage(hrv)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataEncodingStrategy: FitFileEncoder.EncodingStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {

            case .time:
                if let hrv = hrv {

                    if hrv.count > 0 {
                        fileDefs.append(key.fieldDefinition(size: UInt8(hrv.count)))

                        for time in hrv {

                            /// 1000 * s + 0, Time between beats
                            let hrvTime = time.converted(to: UnitDuration.seconds)
                            let value = hrvTime.value.resolutionUInt16(100)

                            msgData.append(Data(from: value.littleEndian))

                        }
                    }

                }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: HrvMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            var encodedMsg = Data()

            let defHeader = RecordHeader(localMessageType: 0, isDataMessage: false)
            encodedMsg.append(defHeader.normalHeader)
            encodedMsg.append(defMessage.encode())

            let recHeader = RecordHeader(localMessageType: 0, isDataMessage: true)
            encodedMsg.append(recHeader.normalHeader)
            encodedMsg.append(msgData)

            return encodedMsg

        } else {
            throw FitError(.encodeError(msg: "HrvMessage contains no Properties Available to Encode"))
        }
    }

}
