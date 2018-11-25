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
    public override class func globalMessageNumber() -> UInt16 {
        return 31
    }

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

    public init(name: String?, capabilities: Capabilities?, sport: Sport?, subSport: SubSport?) {
        self.name = name
        self.capabilities = capabilities
        self.sport = sport
        self.subSport = subSport
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> CourseMessage  {

        var name: String?
        var capabilities: Capabilities?
        var sport: Sport?
        var subSport: SubSport?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("CourseMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

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

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode() throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .sport:
                if let sport = sport {
                    msgData.append(sport.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            case .name:
                if let name = name {
                    if let stringData = name.data(using: .utf8) {
                        msgData.append(stringData)

                        //16 typical size... but we will count the String
                        fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                    }
                }

            case .capabilities:
                if let capabilities = capabilities {
                    msgData.append(Data(from: capabilities.rawValue.littleEndian))

                    fileDefs.append(key.fieldDefinition())
                }

            case .subSport:
                if let subSport = subSport {
                    msgData.append(subSport.rawValue)

                    fileDefs.append(key.fieldDefinition())
                }

            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: CourseMessage.globalMessageNumber(),
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
            throw FitError(.encodeError(msg: "CourseMessage contains no Properties Available to Encode"))
        }
    }

}
