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

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitDecodingError
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

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("EventMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {
                case .timestamp:
                    timestamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)

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

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage Result
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<DefinitionMessage, FitEncodingError> {

//        do {
//            try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)
//        } catch let error as FitEncodingError {
//            return.failure(error)
//        } catch {
//            return.failure(FitEncodingError.fileType(error.localizedDescription))
//        }

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .timestamp:
                if let _ = timeStamp { fileDefs.append(key.fieldDefinition()) }

            case .event:
                if let _ = event { fileDefs.append(key.fieldDefinition()) }
            case .eventType:
                if let _ = eventType { fileDefs.append(key.fieldDefinition()) }
            case .data16:
                if let _ = eventData { fileDefs.append(key.fieldDefinition()) }
            case .data32:
                if let _ = eventMoreData { fileDefs.append(key.fieldDefinition()) }
            case .eventGroup:
                if let _ = eventGroup { fileDefs.append(key.fieldDefinition()) }
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
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: EventMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return.success(defMessage)
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
    }

    /// Encodes the Message into Data
    ///
    /// - Parameters:
    ///   - localMessageType: Message Number, that matches the defintions header number
    ///   - definition: DefinitionMessage
    /// - Returns: Data Result
    internal override func encode(localMessageType: UInt8, definition: DefinitionMessage) -> Result<Data, FitEncodingError> {

        guard definition.globalMessageNumber == type(of: self).globalMessageNumber() else  {
            return.failure(self.encodeWrongDefinitionMessage())
        }

        let msgData = MessageData()

        for key in FitCodingKeys.allCases {

            switch key {
            case .timestamp:
                if let timestamp = timeStamp {
                    msgData.append(timestamp.encode())
                }

            case .event:
                if let event = event {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: event)) {
                        return.failure(error)
                    }
                }

            case .eventType:
                if let eventType = eventType {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: eventType)) {
                        return.failure(error)
                    }
                }

            case .data16:
                if let data16 = eventData {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: data16)) {
                        return.failure(error)
                    }
                }

            case .data32:
                if let data32 = eventMoreData {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: data32)) {
                        return.failure(error)
                    }
                }

            case .eventGroup:
                if let eventGroup = eventGroup {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: eventGroup)) {
                        return.failure(error)
                    }
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
                
            }
        }

        if msgData.message.count > 0 {
            return.success(encodedDataMessage(localMessageType: localMessageType, msgData: msgData.message))
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
    }
}

extension EventMessage: MessageValidator {

    /// Validate Message
    ///
    /// - Parameters:
    ///   - fileType: FileType the Message is being used in
    ///   - dataValidityStrategy: Data Validity Strategy
    /// - Throws: FitError
    internal func validateMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws {

        switch dataValidityStrategy {
        case .none:
        break // do nothing
        case .fileType:
            if fileType == FileType.activity {
                try validateActivity(isGarmin: false)
            }
        case .garminConnect:
            if fileType == FileType.activity {
                try validateActivity(isGarmin: true)
            }
        }
    }

    private func validateActivity(isGarmin: Bool) throws {

        let msg = isGarmin == true ? "GarminConnect" : "Activity Files"

        guard self.timeStamp != nil else {
            throw FitEncodingError.fileType("\(msg) require EventMessage to contain timeStamp, can not be nil")
        }

        guard self.event != nil else {
            throw FitEncodingError.fileType("\(msg) require EventMessage to contain event, can not be nil")
        }

        guard self.eventType != nil else {
            throw FitEncodingError.fileType("\(msg) require EventMessage to contain eventType, can not be nil")
        }

    }
}
