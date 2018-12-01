//
//  SegmentLeaderboardEntryMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 9/8/18.
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

/// FIT Segment Leaderboard Entry Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class SegmentLeaderboardEntryMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 149 }

    /// Message Index
    private(set) public var messageIndex: MessageIndex?

    /// Friendly name assigned to leader
    private(set) public var name: String?

    /// Leader classification
    private(set) public var leaderType: LeaderboardType?

    /// Primary user ID of this leader
    private(set) public var leaderId: ValidatedBinaryInteger<UInt32>?

    /// ID of the activity associated with this leader time
    private(set) public var activityId: ValidatedBinaryInteger<UInt32>?

    /// Segment Time (includes pauses)
    ///
    /// - note: Time in Seconds
    private(set) public var segmentTime: ValidatedBinaryInteger<UInt32>?

    public required init() {}

    public init(messageIndex: MessageIndex? = nil,
                name: String? = nil,
                leaderType: LeaderboardType? = nil,
                leaderId: ValidatedBinaryInteger<UInt32>? = nil,
                activityId: ValidatedBinaryInteger<UInt32>? = nil,
                segmentTime: ValidatedBinaryInteger<UInt32>? = nil) {

        self.messageIndex = messageIndex
        self.name = name
        self.leaderType = leaderType
        self.leaderId = leaderId
        self.activityId = activityId
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> SegmentLeaderboardEntryMessage  {

        var messageIndex: MessageIndex?
        var name: String?
        var leaderType: LeaderboardType?
        var leaderId: ValidatedBinaryInteger<UInt32>?
        var activityId: ValidatedBinaryInteger<UInt32>?
        var segmentTime: ValidatedBinaryInteger<UInt32>?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("SegmentLeaderboardEntryMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .name:
                    name = String.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .boardType:
                    leaderType = LeaderboardType.decode(decoder: &localDecoder,
                                                        definition: definition,
                                                        data: fieldData,
                                                        dataStrategy: dataStrategy)

                case .groupPrimaryKey:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    leaderId = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                        definition: definition,
                                                                        dataStrategy: dataStrategy)

                case .activityID:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    activityId = ValidatedBinaryInteger<UInt32>.validated(value: value,
                                                                          definition: definition,
                                                                          dataStrategy: dataStrategy)

                case .segmentTime:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        /// 1000 * s + 0
                        let value = value.resolutionUInt32(1 / 1000)
                        segmentTime = ValidatedBinaryInteger(value: value, valid: true)
                    } else {
                        segmentTime = ValidatedBinaryInteger.invalidValue(definition.baseType, dataStrategy: dataStrategy)
                    }

                case .messageIndex:
                    messageIndex = MessageIndex.decode(decoder: &localDecoder,
                                                       endian: arch,
                                                       definition: definition,
                                                       data: fieldData)

                }
            }
        }

        return SegmentLeaderboardEntryMessage(messageIndex: messageIndex,
                                              name: name,
                                              leaderType: leaderType,
                                              leaderId: leaderId,
                                              activityId: activityId,
                                              segmentTime: segmentTime)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .name:
                if let name = name {
                    if let stringData = name.data(using: .utf8) {
                        msgData.append(stringData)

                        //16 typical size... but we will count the String
                        fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                    }
                }

            case .boardType:
                if let boardType = leaderType {
                    msgData.append(boardType.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .groupPrimaryKey:
                if let leaderId = leaderId {
                    let value = leaderId.value.resolutionUInt32(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .activityID:
                if let activityId = activityId {
                    let value = activityId.value.resolutionUInt32(1)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .segmentTime:
                if let segmentTime = segmentTime {
                    /// 1000 * s + 0
                    let value = segmentTime.value.resolutionUInt32(1000)

                    msgData.append(Data(from: value.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .messageIndex:
                if let messageIndex = messageIndex {
                    msgData.append(messageIndex.encode())

                    fileDefs.append(key.fieldDefinition())
                }

            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: SegmentLeaderboardEntryMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "SegmentLeaderboardEntryMessage contains no Properties Available to Encode"))
        }
    }

}
