//
//  EventMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/27/18.
//

import Foundation
import DataDecoder

/// FIT Event Message
@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class EventMessage: FitMessage, FitMessageKeys {

    public override func globalMessageNumber() -> UInt16 {
        return 21
    }

    public enum MessageKeys: Int, CodingKey {
        case event              = 0
        case eventType          = 1
        case data16             = 2
        case data32             = 3
        case eventGroup         = 4
        case score              = 7
        case opponentScore      = 8
        case frontGearNumber    = 9
        case frontGear          = 10
        case rearGearNumber     = 11
        case rearGear           = 12
        case timestamp          = 253
    }

    public typealias FitCodingKeys = MessageKeys

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Event Data
    private(set) public var eventData: UInt16?

    /// More Event Data
    private(set) public var eventMoreData: UInt32?

    /// Event
    private(set) public var event: Event?

    /// Event Type
    private(set) public var eventType: EventType?

    /// Event Group
    private(set) public var eventGroup: UInt8?

    internal override init() {}

    public init(timeStamp: FitTime?, eventData: UInt16?, eventMoreData: UInt32?, event: Event?, eventType: EventType?, eventGroup: UInt8?) {
        self.timeStamp = timeStamp
        self.eventData = eventData
        self.eventMoreData = eventMoreData
        self.event = event
        self.eventType = eventType
        self.eventGroup = eventGroup
    }

    internal override func decode(fieldData: Data, definition: DefinitionMessage) throws -> EventMessage  {

        var timeStamp: FitTime?
        var eventData: UInt16?
        var eventMoreData: UInt32?
        var event: Event?
        var eventType: EventType?
        var eventGroup: UInt8?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                print("Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .event:
                    let value = localDecoder.decodeUInt8()
                    event = Event(rawValue: value)

                case .eventType:
                    let value = localDecoder.decodeUInt8()
                    eventType = EventType(rawValue: value)

                case .data16:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        eventData = value
                    }

                case .data32:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        eventMoreData = value
                    }

                case .eventGroup:
                    let value = localDecoder.decodeUInt8()
                    if UInt64(value) != definition.baseType.invalid {
                        eventGroup = value
                    }

                case .score:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))
                    print("score")

                case .opponentScore:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))
                    print("opponentScore")

                case .frontGearNumber:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))
                    print("frontGearNumber")

                case .frontGear:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))
                    print("frontGear")

                case .rearGearNumber:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))
                    print("rearGearNumber")

                case .rearGear:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))
                    print("Unknown Field Number: \(definition.fieldDefinitionNumber)")

                case .timestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32().littleEndian : localDecoder.decodeUInt32().bigEndian
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
