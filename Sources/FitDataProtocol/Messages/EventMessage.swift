//
//  EventMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/27/18.
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

/// FIT Event Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class EventMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 21
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Event Data
    private(set) public var eventData: ValidatedBinaryInteger<UInt16>?

    /// More Event Data
    private(set) public var eventMoreData: ValidatedBinaryInteger<UInt32>?

    /// Event
    private(set) public var event: Event?

    /// Event Type
    private(set) public var eventType: EventType?

    /// Event Group
    private(set) public var eventGroup: ValidatedBinaryInteger<UInt8>?

    public required init() {}

    public init(timeStamp: FitTime?,
                eventData: ValidatedBinaryInteger<UInt16>?,
                eventMoreData: ValidatedBinaryInteger<UInt32>?,
                event: Event?,
                eventType: EventType?,
                eventGroup: ValidatedBinaryInteger<UInt8>?) {
        
        self.timeStamp = timeStamp
        self.eventData = eventData
        self.eventMoreData = eventMoreData
        self.event = event
        self.eventType = eventType
        self.eventGroup = eventGroup
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> EventMessage  {

        var timeStamp: FitTime?
        var eventData: ValidatedBinaryInteger<UInt16>?
        var eventMoreData: ValidatedBinaryInteger<UInt32>?
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
                //print("EventMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

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

                case .data16:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        eventData = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            eventData = ValidatedBinaryInteger(value: UInt16(definition.baseType.invalid), valid: false)
                        }
                    }

                case .data32:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        eventMoreData = ValidatedBinaryInteger(value: value, valid: true)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            eventMoreData = ValidatedBinaryInteger(value: UInt32(definition.baseType.invalid), valid: false)
                        }
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

                case .score:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .opponentScore:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .frontGearNumber:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .frontGear:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .rearGearNumber:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .rearGear:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .timestamp:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        timeStamp = FitTime(time: value)
                    }

                }
            }
        }

        return EventMessage(timeStamp: timeStamp,
                            eventData: eventData,
                            eventMoreData: eventMoreData,
                            event: event,
                            eventType: eventType,
                            eventGroup: eventGroup)
    }
}
