//
//  CourseMessage.swift
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

/// FIT Course Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class CourseMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 31 }

    /// Course Capabilities Options
    public struct Capabilities: OptionSet {
        public let rawValue: UInt32
        public init(rawValue: UInt32) { self.rawValue = rawValue }

        /// Processed
        public static let processed: Capabilities   = Capabilities(rawValue: 0x00000001)
        /// Valid
        public static let valid: Capabilities       = Capabilities(rawValue: 0x00000002)
        /// Time
        public static let time: Capabilities        = Capabilities(rawValue: 0x00000004)
        /// Distance
        public static let distance: Capabilities    = Capabilities(rawValue: 0x00000008)
        /// Position
        public static let position: Capabilities    = Capabilities(rawValue: 0x00000010)
        /// Heart Rate
        public static let heartRate: Capabilities   = Capabilities(rawValue: 0x00000020)
        /// Power
        public static let power: Capabilities       = Capabilities(rawValue: 0x00000040)
        /// Cadence
        public static let cadence: Capabilities     = Capabilities(rawValue: 0x00000080)
        /// Training
        public static let training: Capabilities    = Capabilities(rawValue: 0x00000100)
        /// Navigation
        public static let navigation: Capabilities  = Capabilities(rawValue: 0x00000200)
        /// Bikeway
        public static let bikeway: Capabilities     = Capabilities(rawValue: 0x00000400)
    }

    /// Course Name
    private(set) public var name: String?

    /// Course Capabilities
    private(set) public var capabilities: Capabilities?

    /// Sport
    private(set) public var sport: Sport?

    /// Sub Sport
    private(set) public var subSport: SubSport?

    public required init() {}

    public init(name: String? = nil,
                capabilities: Capabilities? = nil,
                sport: Sport? = nil,
                subSport: SubSport? = nil) {

        self.name = name
        self.capabilities = capabilities
        self.sport = sport
        self.subSport = subSport
    }

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitError
    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> CourseMessage  {

        var name: String?
        var capabilities: Capabilities?
        var sport: Sport?
        var subSport: SubSport?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("CourseMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {

                case .sport:
                    sport = Sport.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .name:
                    name = String.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .capabilities:
                    let value = decodeUInt32(decoder: &localDecoder, endian: arch, data: fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        capabilities = Capabilities(rawValue: value)
                    }

                case .subSport:
                    subSport = SubSport.decode(decoder: &localDecoder,
                                               definition: definition,
                                               data: fieldData,
                                               dataStrategy: dataStrategy)

                }
            }
        }

        return CourseMessage(name: name,
                             capabilities: capabilities,
                             sport: sport,
                             subSport: subSport)
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
            case .sport:
                if let _ = sport { fileDefs.append(key.fieldDefinition()) }
            case .name:
                if let stringData = name?.data(using: .utf8) {
                    //16 typical size... but we will count the String

                    guard stringData.count <= UInt8.max else {
                        return.failure(FitEncodingError.properySize("name size can not exceed 255"))
                    }

                    fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                }
            case .capabilities:
                if let _ = capabilities { fileDefs.append(key.fieldDefinition()) }
            case .subSport:
                if let _ = subSport {fileDefs.append(key.fieldDefinition()) }

            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: CourseMessage.globalMessageNumber(),
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
    /// - Returns: Data representation
    /// - Throws: FitError
    internal override func encode(localMessageType: UInt8, definition: DefinitionMessage) throws -> Data {

        guard definition.globalMessageNumber == type(of: self).globalMessageNumber() else  {
            throw self.encodeWrongDefinitionMessage()
        }

        var msgData = Data()

        for key in FitCodingKeys.allCases {

            switch key {
            case .sport:
                if let sport = sport {
                    msgData.append(sport.rawValue)
                }

            case .name:
                if let name = name {
                    if let stringData = name.data(using: .utf8) {
                        msgData.append(stringData)
                    }
                }

            case .capabilities:
                if let capabilities = capabilities {
                    msgData.append(Data(from: capabilities.rawValue.littleEndian))
                }

            case .subSport:
                if let subSport = subSport {
                    msgData.append(subSport.rawValue)
                }
            }
        }

        if msgData.count > 0 {
            return encodedDataMessage(localMessageType: localMessageType, msgData: msgData)
        } else {
            throw self.encodeNoPropertiesAvailable()
        }
    }
}
