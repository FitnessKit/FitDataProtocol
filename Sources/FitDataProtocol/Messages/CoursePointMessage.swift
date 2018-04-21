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
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CoursePointMessage: FitMessage {

    public override class func globalMessageNumber() -> UInt16 {
        return 32
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Course Point Name
    private(set) public var name: String?

    /// Latitude
    private(set) public var latitude: Measurement<UnitAngle>?

    /// Longitude
    private(set) public var longitude: Measurement<UnitAngle>?

    /// Distance
    private(set) public var distance: Measurement<UnitLength>?

    /// Course Point Type
    private(set) public var pointType: CoursePoint?

    // Is Favorite Point
    private(set) public var isFavorite: Bool?

    public required init() {}

    public init(timeStamp: FitTime?, messageIndex: MessageIndex?, name: String?, latitude: Measurement<UnitAngle>?, longitude: Measurement<UnitAngle>?, distance: Measurement<UnitLength>?, pointType: CoursePoint?,  isFavorite: Bool?) {
        self.timeStamp = timeStamp
        self.messageIndex = messageIndex

        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.distance = distance
        self.pointType = pointType
        self.isFavorite = isFavorite
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> CoursePointMessage  {

        var timestamp: FitTime?
        var messageIndex: MessageIndex?

        var name: String?
        var latitude: Measurement<UnitAngle>?
        var longitude: Measurement<UnitAngle>?
        var distance: Measurement<UnitLength>?
        var pointType: CoursePoint?
        var isFavorite: Bool?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData.fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                print("CoursePointMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .latitude:
                    let value = arch == .little ? localDecoder.decodeInt32().littleEndian : localDecoder.decodeInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = Conversion.degressFromSemiCircles(Double(value))
                        latitude = Measurement(value: value, unit: UnitAngle.degrees)
                    }

                case .longitude:
                    let value = arch == .little ? localDecoder.decodeInt32().littleEndian : localDecoder.decodeInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1 * semicircles + 0
                        let value = Conversion.degressFromSemiCircles(Double(value))
                        longitude = Measurement(value: value, unit: UnitAngle.degrees)
                    }

                case .distance:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 100 * m + 0
                        let value = Double(value) / 100
                        distance = Measurement(value: value, unit: UnitLength.meters)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            distance = Measurement(value: Double(definition.baseType.invalid), unit: UnitLength.meters)
                        }
                    }

                case .pointType:
                    let value = localDecoder.decodeUInt8()
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
                    let stringData = localDecoder.decodeData(length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        name = stringData.smartString
                    }

                case .favorite:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        isFavorite = value.boolValue
                    }

                case .timestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        timestamp = FitTime(time: value)
                    }

                case .messageIndex:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        messageIndex = MessageIndex(value: value)
                    }

                }
            }
        }

        return CoursePointMessage(timeStamp: timestamp,
                                  messageIndex: messageIndex,
                                  name: name,
                                  latitude: latitude,
                                  longitude: longitude,
                                  distance: distance,
                                  pointType: pointType,
                                  isFavorite: isFavorite)
    }
}

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension CoursePointMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    ///
    public enum MessageKeys: Int, CodingKey {
        case timestamp      = 1
        case latitude       = 2
        case longitude      = 3
        case distance       = 4
        case pointType      = 5
        case name           = 6
        case favorite       = 7

        case messageIndex   = 254
    }
}
