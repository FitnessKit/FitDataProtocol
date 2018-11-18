//
//  PowerZoneMessage.swift
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

/// FIT Power Zone Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class PowerZoneMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 9
    }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Power Zone Name
    private(set) public var name: String?

    /// Power Zone High Level
    private(set) public var highLevel: ValidatedMeasurement<UnitPower>?

    public required init() {}

    public init(messageIndex: MessageIndex?, name: String?, highLevel: ValidatedMeasurement<UnitPower>?) {
        self.messageIndex = messageIndex
        self.name = name
        self.highLevel = highLevel
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> PowerZoneMessage  {

        var messageIndex: MessageIndex?
        var name: String?
        var highLevel: ValidatedMeasurement<UnitPower>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("PowerZoneMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .highValue:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * watts + 0
                        let value = value.resolution(1)
                        highLevel = ValidatedMeasurement(value: value, valid: true, unit: UnitPower.watts)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            highLevel = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitPower.watts)
                        }
                    }

                case .name:
                    let stringData = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        name = stringData.smartString
                    }

                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                }
            }
        }

        return PowerZoneMessage(messageIndex: messageIndex,
                                  name: name,
                                  highLevel: highLevel)
    }
}
