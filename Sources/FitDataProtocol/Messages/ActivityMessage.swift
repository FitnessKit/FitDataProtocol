//
//  ActivityMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/28/18.
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

/// FIT Activity Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class ActivityMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 34
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Total Timer Time
    ///
    /// Excludes pauses
    private(set) public var totalTimerTime: Measurement<UnitDuration>?

    /// Local Timestamp
    private(set) public var localTimeStamp: FitTime?

    /// Number of Sessions
    private(set) public var numberOfSessions: ValidatedBinaryInteger<UInt16>?

    /// Activity
    private(set) public var activity: Activity?

    /// Event
    private(set) public var event: Event?

    /// Event Type
    private(set) public var eventType: EventType?

    /// Event Group
    private(set) public var eventGroup: ValidatedBinaryInteger<UInt8>?


    public required init() {}

    public init(timeStamp: FitTime?,
                totalTimerTime: Measurement<UnitDuration>?,
                localTimeStamp: FitTime?,
                numberOfSessions: ValidatedBinaryInteger<UInt16>?,
                activity: Activity?,
                event: Event?,
                eventType: EventType?,
                eventGroup: ValidatedBinaryInteger<UInt8>?) {
        
        self.timeStamp = timeStamp
        self.totalTimerTime = totalTimerTime
        self.localTimeStamp = localTimeStamp
        self.numberOfSessions = numberOfSessions
        self.event = event
        self.eventType = eventType
        self.eventGroup = eventGroup
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> ActivityMessage  {

        var timeStamp: FitTime?
        var totalTimerTime: Measurement<UnitDuration>?
        var localTimeStamp: FitTime?
        var numberOfSessions: ValidatedBinaryInteger<UInt16>?
        var activity: Activity?
        var event: Event?
        var eventType: EventType?
        var eventGroup: ValidatedBinaryInteger<UInt8>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("ActivityMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {
                case .totalTimerTime:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        // 1000 * s + 0
                        let value = value.resolution(1 / 1000)
                        totalTimerTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .numberOfSessions:
                    let value = arch == .little ? localDecoder.decodeUInt16(fieldData.fieldData).littleEndian : localDecoder.decodeUInt16(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        numberOfSessions = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            numberOfSessions = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .activityType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        activity = Activity(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            activity = Activity.invalid
                        }
                    }

                case .event:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        event = Event(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            event = Event.invalid
                        }
                    }

                case .eventType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        eventType = EventType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            eventType = EventType.invalid
                        }
                    }

                case .localTimestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        localTimeStamp = FitTime(time: value, isLocal: true)
                    }

                case .eventGroup:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        eventGroup = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            eventGroup = ValidatedBinaryInteger(value: UInt8(definition.baseType.invalid), valid: false)
                        }
                    }

                case .timestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        timeStamp = FitTime(time: value)
                    }
                }

            }
        }

        return ActivityMessage(timeStamp: timeStamp,
                               totalTimerTime: totalTimerTime,
                               localTimeStamp: localTimeStamp,
                               numberOfSessions: numberOfSessions,
                               activity: activity,
                               event: event, eventType: eventType,
                               eventGroup: eventGroup)
    }
}
