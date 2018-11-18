//
//  HeartrateProfileMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/21/18.
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
import FitnessUnits
import AntMessageProtocol

/// FIT HRM Profile Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class HeartrateProfileMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 4
    }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Enabled
    private(set) public var enabled: Bool?

    /// ANT ID
    private(set) public var antID: ValidatedBinaryInteger<UInt16>?

    /// Log HRV
    private(set) public var logHrv: Bool?

    /// Transmission Type
    private(set) public var transmissionType: TransmissionType?

    public required init() {}

    public init(messageIndex: MessageIndex?,
                enabled: Bool?,
                antID: ValidatedBinaryInteger<UInt16>?,
                logHrv: Bool?,
                transmissionType: TransmissionType?) {
        
        self.messageIndex = messageIndex
        self.enabled = enabled
        self.antID = antID
        self.logHrv = logHrv
        self.transmissionType = transmissionType
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> HeartrateProfileMessage  {

        var messageIndex: MessageIndex?
        var enabled: Bool?
        var antID: ValidatedBinaryInteger<UInt16>?
        var logHrv: Bool?
        var transmissionType: TransmissionType?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("HeartrateProfileMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {
                case .enabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        enabled = value.boolValue
                    }

                case .antID:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        antID = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            antID = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .logHrv:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        logHrv = value.boolValue
                    }

                case .transType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        transmissionType = TransmissionType(value)
                    }

                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                }
            }
        }

        return HeartrateProfileMessage(messageIndex: messageIndex,
                                       enabled: enabled,
                                       antID: antID,
                                       logHrv: logHrv,
                                       transmissionType: transmissionType)
    }
}
