//
//  ScheduleMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 8/25/18.
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

/// FIT Schedule Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class ScheduleMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 28
    }

    /// Manufacturer
    ///
    /// Corresponds to file_id of scheduled workout / course
    private(set) public var manufacturer: Manufacturer?

    /// Product
    ///
    /// Corresponds to file_id of scheduled workout / course
    private(set) public var product: ValidatedBinaryInteger<UInt16>?

    /// Serial Number
    ///
    /// Corresponds to file_id of scheduled workout / course
    private(set) public var serialNumber: ValidatedBinaryInteger<UInt32>?

    /// Time Created
    ///
    /// Corresponds to file_id of scheduled workout / course
    private(set) public var timeCreated: FitTime?

    /// Completed
    ///
    /// True if Activity has been started
    private(set) public var completed: Bool?

    /// Schedule Type
    private(set) public var scheduleType: ScheduleType?

    /// Scheduled Time
    private(set) public var scheduledTime: FitTime?

    public required init() {}

    public init(manufacturer: Manufacturer?,
                product: ValidatedBinaryInteger<UInt16>?,
                serialNumber: ValidatedBinaryInteger<UInt32>?,
                timeCreated: FitTime?,
                completed: Bool?,
                scheduleType: ScheduleType?,
                scheduledTime: FitTime?) {

        self.manufacturer = manufacturer
        self.product = product
        self.serialNumber = serialNumber
        self.timeCreated = timeCreated
        self.completed = completed
        self.scheduleType = scheduleType
        self.scheduledTime = scheduledTime
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> ScheduleMessage  {

        var manufacturer: Manufacturer?
        var product: ValidatedBinaryInteger<UInt16>?
        var serialNumber: ValidatedBinaryInteger<UInt32>?
        var timeCreated: FitTime?
        var completed: Bool?
        var scheduleType: ScheduleType?
        var scheduledTime: FitTime?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("SoftwareMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .manufacturer:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        manufacturer = Manufacturer.company(id: value)
                    }

                case .product:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if Int64(value) != definition.baseType.invalid {
                        product = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            product = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .serialNumber:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        serialNumber = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            serialNumber = ValidatedBinaryInteger(value: UInt32(definition.baseType.invalid), valid: false)
                        }
                    }

                case .timeCreated:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        timeCreated = FitTime(time: value)
                    }

                case .completed:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        completed = value.boolValue
                    }

                case .scheduleType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        scheduleType = ScheduleType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            scheduleType = ScheduleType.invalid
                        }
                    }

                case .scheduledTime:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        scheduledTime = FitTime(time: value, isLocal: true)
                    }

                }
            }
        }

        return ScheduleMessage(manufacturer: manufacturer,
                               product: product,
                               serialNumber: serialNumber,
                               timeCreated: timeCreated,
                               completed: completed,
                               scheduleType: scheduleType,
                               scheduledTime: scheduledTime)
    }
}
