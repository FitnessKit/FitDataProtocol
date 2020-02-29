//
//  FitFileDecoder.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/21/18.
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

/// FIT File Decoder
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
public struct FitFileDecoder {
    private var messageData: Data
    private var definitionDict: [UInt8 : DefinitionMessage]
    private var fieldDescription: [FieldDescriptionMessage] = [FieldDescriptionMessage]()

    /// Default FIT Messages for Decoding
    public static let defaultMessages = [FileIdMessage.self,
                                         CapabilitiesMessage.self,
                                         DeviceSettingsMessage.self,
                                         UserProfileMessage.self,
                                         HeartrateProfileMessage.self,
                                         StrideSpeedDistanceMonitorProfileMessage.self,
                                         BikeProfileMessage.self,
                                         ZonesTargetMessage.self,
                                         HeartRateZoneMessage.self,
                                         PowerZoneMessage.self,
                                         MetZoneMessage.self,
                                         SportMessage.self,
                                         GoalMessage.self,
                                         SessionMessage.self,
                                         LapMessage.self,
                                         RecordMessage.self,
                                         EventMessage.self,
                                         DeviceInfoMessage.self,
                                         WorkoutMessage.self,
                                         WorkoutStepMessage.self,
                                         ScheduleMessage.self,
                                         WeightScaleMessage.self,
                                         CourseMessage.self,
                                         CoursePointMessage.self,
                                         TotalsMessage.self,
                                         ActivityMessage.self,
                                         SoftwareMessage.self,
                                         FileCapabilitiesMessage.self,
                                         FileCreatorMessage.self,
                                         BloodPressureMessage.self,
                                         SpeedZoneMessage.self,
                                         HrvMessage.self,
                                         AntChannelIdMessage.self,
                                         SlaveDeviceMessage.self,
                                         ConnectivityMessage.self,
                                         WeatherConditionsMessage.self,
                                         WeatherAlertMessage.self,
                                         CadenceZoneMessage.self,
                                         SegmentLeaderboardEntryMessage.self,
                                         SegmentPointMessage.self,
                                         WorkoutSessionMessage.self,
                                         WatchfaceSettingsMessage.self,
                                         VideoMessage.self,
                                         FieldDescriptionMessage.self,
                                         DeveloperDataIdMessage.self,
                                         SetMessage.self,
                                         StressLevelMessage.self,
                                         ExerciseTitleMessage.self,
                                         JumpMessage.self
                                        ]

    /// Options for CRC Checking
    public enum CrcCheckingStrategy {
        /// Throw upon encountering invalid CRCs. This is the default strategy.
        case `throws`
        /// Don't Check CRC Values
        case ignore
    }

    /// The strategy to use for CRC Checking. Defaults to `.throws`.
    public var crcCheckingStrategy: CrcCheckingStrategy

    /// Init Fit File Decoder
    ///
    /// - Parameters:
    ///   - crcCheckingStrategy: CRC Checking Strategy
    public init(crcCheckingStrategy: CrcCheckingStrategy = .throws) {
        self.crcCheckingStrategy = crcCheckingStrategy
        self.messageData = Data()
        self.definitionDict = [UInt8 : DefinitionMessage]()
    }

    /// Decodes the FIT File Data into FitMessage Objects
    ///
    /// - Parameters:
    ///   - data: FIT File data
    ///   - messages: FitMessage Types to Decode
    ///   - decoded: Decoded FitMessages
    /// - Throws: FitDecodingError
    public mutating func decode(data: Data, messages: [FitMessage.Type], decoded: ((_: FitMessage) -> Void)? ) throws {

        /// Clear out any old data
        /// This will help where they use the same Decoder twice for some reason
        messageData = Data()
        definitionDict = [UInt8 : DefinitionMessage]()

        let globalMsgs = messages.map {$0.globalMessageNumber()}
        let duplicates = Array(Set(globalMsgs.filter({ (i: UInt16) in globalMsgs.filter({ $0 == i }).count > 1})))

        guard duplicates.isEmpty else {
            throw FitDecodingError.duplicateFitMessage
        }

        let shouldValidate: Bool
        switch crcCheckingStrategy {
        case .ignore:
            shouldValidate = false
        case .throws:
            shouldValidate = true
        }

        messageData = try readFitFile(data: data, validateCrc: shouldValidate).get()
        
        var decoder = DecodeData()

        repeat {
            let header = RecordHeader.decode(decoder: &decoder, data: messageData)
            //print(header)

            if header.isDataMessage == false {
                let lastDefinition = try DefinitionMessage.decode(decoder: &decoder, data: messageData, header: header).get()
                definitionDict[header.localMessageType] = lastDefinition

                //print(definitionDict[header.localMessageType] as Any)

            } else {
                // We have a Data Message
                var hasMessageDecoder = false
                var messageType: FitMessage!
                var currentGlobalMessage: UInt16!

                if let message = messages.filter({
                    $0.globalMessageNumber() == definitionDict[header.localMessageType]!.globalMessageNumber
                }).first {
                    hasMessageDecoder = true
                    messageType = message.init()
                    currentGlobalMessage = message.globalMessageNumber()
                }
                                
                var fieldSize: Int = 0
                for msg in definitionDict[header.localMessageType]!.fieldDefinitions {
                    fieldSize = fieldSize + Int(msg.size)
                }

                let stdData = decoder.decodeData(messageData, length: fieldSize)

                var devSize: Int = 0
                for msg in definitionDict[header.localMessageType]!.developerFieldDefinitions {
                    devSize = devSize + Int(msg.size)
                }

                let devData = decoder.decodeData(messageData, length: devSize)

                let fieldData = FieldData(fieldData: stdData, developerFieldData: devData)

                if hasMessageDecoder == true {
                    let fieldDescriptions = self.fieldDescription.compactMap { $0.messageNumber == currentGlobalMessage ? $0 : nil }
                                    
                    let result = messageType.decode(fieldData: fieldData,
                                                    definition: definitionDict[header.localMessageType]!)
                    
                    switch result {
                    case .success(let message):
                        if let message = message as? FieldDescriptionMessage {
                            self.fieldDescription.append(message)
                        } else {
                            let devData = unwrapDeveloperData(message: message, fieldsDescriptions: fieldDescriptions)
                            message.developerValues = devData
                            decoded?(message)
                        }
                    case .failure(let error):
                        throw error
                    }
                    
                } else {
                    //print("NO Decoder for Global Message: \(definitionDict[header.localMessageType]?.globalMessageNumber)")
                }

            }

        } while decoder.index != messageData.count

    }
}

private extension FitFileDecoder {
    
    /// Creates the Developer Data Values For the FitMessage
    /// - Parameter message: FitMessage
    /// - Parameter fieldsDescriptions: [FieldDescriptionMessage]
    func unwrapDeveloperData(message: FitMessage, fieldsDescriptions: [FieldDescriptionMessage]) -> [DeveloperDataBox] {
        
        var values = [DeveloperDataBox]()
        
        if let devData = message.developerData {
            
            for def in fieldsDescriptions {
                
                for devDataType in devData {
                    if let box = def.decodeDeveloperDataType(developerData: devDataType) {
                        values.append(box)
                    }
                }
            }
        }
        
        return values
    }
    
}

@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
private extension FitFileDecoder {

    /// Reads File data and validates
    ///
    /// - Parameters:
    ///   - data: FIT File Data
    ///   - validateCrc: Should Validate CRC Values
    /// - Returns: Data Result
    private func readFitFile(data: Data, validateCrc: Bool) -> Result<Data, FitDecodingError> {

        let header: FileHeader!

        switch FileHeader.decode(data: data, validateCrc: validateCrc) {
        case .success(let fileHeader):
            header = fileHeader
        case .failure(let error):
            return.failure(error)
        }

        var decoder = DecodeData()

        let _ = decoder.decodeData(data, length: Int(header.headerSize))

        let msgData = decoder.decodeData(data, length: Int(header.dataSize))

        let fileCrc = decoder.decodeUInt16(data)

        if validateCrc == true && header.protocolVersion >= 20 {
            let crcCheck = CRC16(data: msgData).crc

            guard fileCrc == crcCheck else { return.failure(FitDecodingError.invalidFileCrc) }
        }

        return.success(msgData)
    }
}
