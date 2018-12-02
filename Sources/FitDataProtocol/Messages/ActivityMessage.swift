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
///
/// Provides a high level description of the overall activity file.
/// This includes overall time, number of sessions and the type of each session
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class ActivityMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 34 }

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

    public init(timeStamp: FitTime? = nil,
                totalTimerTime: Measurement<UnitDuration>? = nil,
                localTimeStamp: FitTime? = nil,
                numberOfSessions: ValidatedBinaryInteger<UInt16>? = nil,
                activity: Activity? = nil,
                event: Event? = nil,
                eventType: EventType? = nil,
                eventGroup: ValidatedBinaryInteger<UInt8>? = nil) {
        
        self.timeStamp = timeStamp
        self.totalTimerTime = totalTimerTime
        self.localTimeStamp = localTimeStamp
        self.numberOfSessions = numberOfSessions
        self.activity = activity
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
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        // 1000 * s + 0
                        let value = value.resolution(1 / 1000)
                        totalTimerTime = Measurement(value: value, unit: UnitDuration.seconds)
                    }

                case .numberOfSessions:
                    let value = decodeUInt16(decoder: &localDecoder, endian: arch, data: fieldData)
                    numberOfSessions = ValidatedBinaryInteger<UInt16>.validated(value: value,
                                                                                definition: definition,
                                                                                dataStrategy: dataStrategy)

                case .activityType:
                    activity = Activity.decode(decoder: &localDecoder,
                                               definition: definition,
                                               data: fieldData,
                                               dataStrategy: dataStrategy)

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

                case .localTimestamp:
                    localTimeStamp = FitTime.decode(decoder: &localDecoder,
                                                    endian: arch,
                                                    definition: definition,
                                                    data: fieldData,
                                                    isLocal: true)

                case .eventGroup:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    eventGroup = ValidatedBinaryInteger<UInt8>.validated(value: value,
                                                                         definition: definition,
                                                                         dataStrategy: dataStrategy)

                case .timestamp:
                    timeStamp = FitTime.decode(decoder: &localDecoder,
                                               endian: arch,
                                               definition: definition,
                                               data: fieldData)
                }

            }
        }

        return ActivityMessage(timeStamp: timeStamp,
                               totalTimerTime: totalTimerTime,
                               localTimeStamp: localTimeStamp,
                               numberOfSessions: numberOfSessions,
                               activity: activity,
                               event: event,
                               eventType: eventType,
                               eventGroup: eventGroup)
    }

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage
    /// - Throws: FitError
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws -> DefinitionMessage {

        try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .totalTimerTime:
                if var _ = totalTimerTime { fileDefs.append(key.fieldDefinition()) }
            case .numberOfSessions:
                if let _ = numberOfSessions { fileDefs.append(key.fieldDefinition()) }
            case .activityType:
                if let _ = activity { fileDefs.append(key.fieldDefinition()) }
            case .event:
                if let _ = event { fileDefs.append(key.fieldDefinition()) }
            case .eventType:
                if let _ = eventType { fileDefs.append(key.fieldDefinition()) }
            case .localTimestamp:
                if let _ = localTimeStamp { fileDefs.append(key.fieldDefinition()) }
            case .eventGroup:
                if let _ = eventGroup { fileDefs.append(key.fieldDefinition()) }
            case .timestamp:
                if let _ = timeStamp { fileDefs.append(key.fieldDefinition()) }
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: ActivityMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return defMessage
        } else {
            throw FitError(.encodeError(msg: "ActivityMessage contains no Properties Available to Encode"))
        }
    }

    /// Encodes the Message into Data
    ///
    /// - Parameters:
    ///   - localMessageType: Message Number, that matches the defintions header number
    ///   - definition: DefinitionMessage
    /// - Returns: Data representation
    /// - Throws: FitError
    internal override func encode(localMessageType: UInt8, definition: DefinitionMessage) throws -> Data {

        guard definition.globalMessageNumber == type(of: self).globalMessageNumber() else  {
            throw FitError(.encodeError(msg: "Wrong DefinitionMessage used for Encoding ActivityMessage"))
        }

        var msgData = Data()

        for key in FitCodingKeys.allCases {

            switch key {
            case .totalTimerTime:
                if var totalTimerTime = totalTimerTime {
                    // 1000 * s + 0
                    totalTimerTime = totalTimerTime.converted(to: UnitDuration.seconds)
                    let value = totalTimerTime.value.resolutionUInt32(1000)

                    msgData.append(Data(from: value.littleEndian))
                }

            case .numberOfSessions:
                if let numberOfSessions = numberOfSessions {
                    msgData.append(Data(from: numberOfSessions.value.littleEndian))
                }

            case .activityType:
                if let activityType = activity {
                    msgData.append(activityType.rawValue)
                }

            case .event:
                if let event = event {
                    msgData.append(event.rawValue)
                }

            case .eventType:
                if let eventType = eventType {
                    msgData.append(eventType.rawValue)
                }

            case .localTimestamp:
                if let localTimeStamp = localTimeStamp {
                    msgData.append(localTimeStamp.encode(isLocal: true))
                }

            case .eventGroup:
                if let eventGroup = eventGroup {
                    msgData.append(eventGroup.value)
                }

            case .timestamp:
                if let timestamp = timeStamp {
                    msgData.append(timestamp.encode())
                }
            }
        }

        if msgData.count > 0 {
            var encodedMsg = Data()

            let recHeader = RecordHeader(localMessageType: localMessageType, isDataMessage: true)
            encodedMsg.append(recHeader.normalHeader)
            encodedMsg.append(msgData)

            return encodedMsg

        } else {
            throw FitError(.encodeError(msg: "ActivityMessage contains no Properties Available to Encode"))
        }
    }

}

private extension ActivityMessage {

    private func validateMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws {

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
            throw FitError(.encodeError(msg: "\(msg) require ActivityMessage to contain timeStamp, can not be nil"))
        }

        guard self.numberOfSessions != nil else {
            throw FitError(.encodeError(msg: "\(msg) require ActivityMessage to contain numberOfSessions, can not be nil"))
        }

        guard self.activity != nil else {
            throw FitError(.encodeError(msg: "\(msg) require ActivityMessage to contain activity, can not be nil"))
        }

        guard self.event != nil else {
            throw FitError(.encodeError(msg: "\(msg) require ActivityMessage to contain event, can not be nil"))
        }

        guard self.eventType != nil else {
            throw FitError(.encodeError(msg: "\(msg) require ActivityMessage to contain eventType, can not be nil"))
        }

    }
}
