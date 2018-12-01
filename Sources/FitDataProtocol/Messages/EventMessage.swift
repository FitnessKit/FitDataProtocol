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
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class EventMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 21 }

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

    public init(timeStamp: FitTime? = nil,
                eventData: ValidatedBinaryInteger<UInt16>? = nil,
                eventMoreData: ValidatedBinaryInteger<UInt32>? = nil,
                event: Event? = nil,
                eventType: EventType? = nil,
                eventGroup: ValidatedBinaryInteger<UInt8>? = nil) {
        
        self.timeStamp = timeStamp
        self.eventData = eventData
        self.eventMoreData = eventMoreData
        self.event = event
        self.eventType = eventType
        self.eventGroup = eventGroup
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> EventMessage  {

        var timestamp: FitTime?
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
                    event = Event.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .eventType:
                    eventType = EventType.decode(decoder: &localDecoder,
                                                 definition: definition,
                                                 data: fieldData,
                                                 dataStrategy: dataStrategy)

                case .data16:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    eventData = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                         definition: definition,
                                                                         dataStrategy: dataStrategy)

                case .data32:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    eventMoreData = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                             definition: definition,
                                                                             dataStrategy: dataStrategy)

                case .eventGroup:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    eventGroup = ValidatedBinaryInteger<UInt8>.validated(value: value,
                                                                         definition: definition,
                                                                         dataStrategy: dataStrategy)

                case .score:
                    // not populated directly
                    // We still need to pull this data off the stack just in case it is included
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .opponentScore:
                    // not populated directly
                    // We still need to pull this data off the stack just in case it is included
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .frontGearNumber:
                    // not populated directly
                    // We still need to pull this data off the stack just in case it is included
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .frontGear:
                    // not populated directly
                    // We still need to pull this data off the stack just in case it is included
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .rearGearNumber:
                    // not populated directly
                    // We still need to pull this data off the stack just in case it is included
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .rearGear:
                    // not populated directly
                    // We still need to pull this data off the stack just in case it is included
                    let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))

                case .timestamp:
                    timestamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

                }
            }
        }

        return EventMessage(timeStamp: timestamp,
                            eventData: eventData,
                            eventMoreData: eventMoreData,
                            event: event,
                            eventType: eventType,
                            eventGroup: eventGroup)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataEncodingStrategy: FitFileEncoder.EncodingStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .event:
                if let event = event {
                    msgData.append(event.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .eventType:
                if let eventType = eventType {
                    msgData.append(eventType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .data16:
                if let data16 = eventData {
                    msgData.append(Data(from: data16.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .data32:
                if let data32 = eventMoreData {
                    msgData.append(Data(from: data32.value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .eventGroup:
                if let eventGroup = eventGroup {
                    msgData.append(eventGroup.value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .score:
                break // not populated directly
            case .opponentScore:
                break // not populated directly
            case .frontGearNumber:
                break // not populated directly
            case .frontGear:
                break // not populated directly
            case .rearGearNumber:
                break // not populated directly
            case .rearGear:
                break // not populated directly
                
            case .timestamp:
                if let timestamp = timeStamp {
                    msgData.append(timestamp.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: EventMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            var encodedMsg = Data()

            let defHeader = RecordHeader(localMessageType: 0, isDataMessage: false)
            encodedMsg.append(defHeader.normalHeader)
            encodedMsg.append(defMessage.encode())

            let recHeader = RecordHeader(localMessageType: 0, isDataMessage: true)
            encodedMsg.append(recHeader.normalHeader)
            encodedMsg.append(msgData)

            return encodedMsg

        } else {
            throw FitError(.encodeError(msg: "EventMessage contains no Properties Available to Encode"))
        }
    }

}
