//
//  CoursePointMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/10/18.
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
import AntMessageProtocol
import FitnessUnits

/// FIT Course Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CoursePointMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 32
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Course Point Name
    private(set) public var name: String?

    /// Position
    private(set) public var position: Position

    /// Distance
    private(set) public var distance: ValidatedMeasurement<UnitLength>?

    /// Course Point Type
    private(set) public var pointType: CoursePoint?

    // Is Favorite Point
    private(set) public var isFavorite: Bool?

    public required init() {
        self.position = Position(latitude: nil, longitude: nil)
    }

    public init(timeStamp: FitTime?,
                messageIndex: MessageIndex?,
                name: String?,
                position: Position,
                distance: ValidatedMeasurement<UnitLength>?,
                pointType: CoursePoint?,
                isFavorite: Bool?) {
        
        self.timeStamp = timeStamp
        self.messageIndex = messageIndex

        self.name = name
        self.position = position
        self.distance = distance
        self.pointType = pointType
        self.isFavorite = isFavorite
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> CoursePointMessage  {

        var timestamp: FitTime?
        var messageIndex: MessageIndex?

        var name: String?
        var latitude: ValidatedMeasurement<UnitAngle>?
        var longitude: ValidatedMeasurement<UnitAngle>?
        var distance: ValidatedMeasurement<UnitLength>?
        var pointType: CoursePoint?
        var isFavorite: Bool?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("CoursePointMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .latitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        latitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            latitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitAngle.garminSemicircle)
                        }
                    }

                case .longitude:
                    let value = decodeInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if Int64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = value.resolution(1)
                        longitude = ValidatedMeasurement(value: value, valid: true, unit: UnitAngle.garminSemicircle)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            longitude = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitAngle.garminSemicircle)
                        }
                    }

                case .distance:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * m + 0
                        let value = value.resolution(1 / 100)
                        distance = ValidatedMeasurement(value: value, valid: true, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            distance = ValidatedMeasurement(value: Double(definition.baseType.invalid), valid: false, unit: UnitLength.meters)
                        }
                    }

                case .pointType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        pointType = CoursePoint(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            pointType = CoursePoint.invalid
                        }
                    }

                case .name:
                    let stringData = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        name = stringData.smartString
                    }

                case .favorite:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        isFavorite = value.boolValue
                    }

                case .timestamp:
                    timestamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                }
            }
        }

        /// setup Position
        let position = Position(latitude: latitude, longitude: longitude)

        return CoursePointMessage(timeStamp: timestamp,
                                  messageIndex: messageIndex,
                                  name: name,
                                  position: position,
                                  distance: distance,
                                  pointType: pointType,
                                  isFavorite: isFavorite)
    }
}
