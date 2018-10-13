//
//  SpeedZoneMessage.swift
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

/// FIT Speed Zone Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class SpeedZoneMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 53
    }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Speed Zone Name
    private(set) public var name: String?

    /// Speed Zone High Level
    private(set) public var highLevel: Measurement<UnitSpeed>?

    public required init() {}

    public init(messageIndex: MessageIndex?,
                name: String?,
                highLevel: Measurement<UnitSpeed>?) {
        
        self.messageIndex = messageIndex
        self.name = name
        self.highLevel = highLevel

    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> SpeedZoneMessage  {

        var messageIndex: MessageIndex?
        var name: String?
        var highLevel: Measurement<UnitSpeed>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("HeartRateZoneMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .highValue:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1000 * m/s + 0
                        let value = value.resolution(1 / 1000)
                        highLevel = Measurement(value: value, unit: UnitSpeed.metersPerSecond)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            highLevel = Measurement(value: Double(definition.baseType.invalid), unit: UnitSpeed.metersPerSecond)
                        }
                    }

                case .name:
                    let stringData = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        name = stringData.smartString
                    }

                case .messageIndex:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        messageIndex = MessageIndex(value: value)
                    }

                }
            }
        }

        return SpeedZoneMessage(messageIndex: messageIndex,
                                name: name,
                                highLevel: highLevel)
    }
}
