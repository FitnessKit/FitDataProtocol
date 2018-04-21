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

/// FIT HRM Profile Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class HeartrateProfileMessage: FitMessage {

    public override class func globalMessageNumber() -> UInt16 {
        return 4
    }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Enabled
    private(set) public var enabled: Bool?

    /// ANT ID
    private(set) public var antID: UInt16?

    /// Log HRV
    private(set) public var logHrv: Bool?

    /// Transmission Type
    private(set) public var transmissionType: UInt8?

    public required init() {}

    public init(messageIndex: MessageIndex?, enabled: Bool?, antID: UInt16?, logHrv: Bool?, transmissionType: UInt8?) {
        self.messageIndex = messageIndex
        self.enabled = enabled
        self.antID = antID
        self.logHrv = logHrv
        self.transmissionType = transmissionType
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> HeartrateProfileMessage  {

        var messageIndex: MessageIndex?
        var enabled: Bool?
        var antID: UInt16?
        var logHrv: Bool?
        var transmissionType: UInt8?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData.fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                print("HrvMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {
                case .enabled:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        enabled = value.boolValue
                    }

                    
                case .antID:
                    let value = localDecoder.decodeUInt16()
                    if UInt64(value) != definition.baseType.invalid {
                        antID = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            antID = UInt16(definition.baseType.invalid)
                        }
                    }


                case .logHrv:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        logHrv = value.boolValue
                    }


                case .transType:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        transmissionType = value
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            transmissionType = UInt8(definition.baseType.invalid)
                        }
                    }


                case .messageIndex:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        messageIndex = MessageIndex(value: value)
                    }

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

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension HeartrateProfileMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    public enum MessageKeys: Int, CodingKey {
        case enabled                = 0
        case antID                  = 1
        case logHrv                 = 2
        case transType              = 3

        case messageIndex           = 254
    }
}
