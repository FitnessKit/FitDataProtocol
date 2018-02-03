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
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
public struct FitFileDecoder {
    private var messageData: Data
    private var definitionDict: [UInt8 : DefinitionMessage]

    /// Default FIT Messages for Decoding
    public static let defaultMessages = [FileIdMessage.self,
                                         FileCreatorMessage.self,
                                         UserProfileMessage.self,
                                         SportMessage.self,
                                         RecordMessage.self,
                                         EventMessage.self,
                                         WorkoutMessage.self,
                                         ActivityMessage.self,
                                         HrvMessage.self,
                                         DeveloperDataIdMessage.self,
                                        ]

    /// Options for CRC Checking
    public enum CrcDecodingStrategy {
        /// Throw upon encountering invalid CRCs. This is the default strategy.
        case `throws`
        /// Don't Check CRC Values
        case ignore
    }

    /// The strategy to use for CRC Checking. Defaults to `.throws`.
    public var crcDecodingStrategy: CrcDecodingStrategy

    /// Options for Data Decoding
    public enum DataDecodingStrategy {
        /// Use nil for Invalid Values.  This is the default strategy.
        case `nil`
        /// Decode using Invalid Value
        case useInvalid
    }

    /// The strategy to use for Data Decoding. Defaults to `.nil`.
    public var dataDecodingStrategy: DataDecodingStrategy


    public init(crcDecodingStrategy: CrcDecodingStrategy = .throws, dataDecodingStrategy: DataDecodingStrategy = .nil) {
        self.crcDecodingStrategy = crcDecodingStrategy
        self.dataDecodingStrategy = dataDecodingStrategy
        self.messageData = Data()
        self.definitionDict = [UInt8 : DefinitionMessage]()
    }

    public mutating func decode(data: Data, messages: [FitMessage.Type], decoded: ((_: FitMessage) -> Void)? ) throws {

        var shouldValidate: Bool = true
        switch crcDecodingStrategy {
        case .ignore:
            shouldValidate = false
        default:
            shouldValidate = true
        }

        try readFitFile(data: data, validateCrc: shouldValidate)

        var decoder = DataDecoder(messageData)

        repeat {
            let header = try RecordHeader.decode(decoder: &decoder)
            print(header)

            if header.isDataMessage == false {
                let lastDefinition = try DefinitionMessage.decode(decoder: &decoder, header: header)
                definitionDict[header.localMessageType] = lastDefinition

                print(definitionDict[header.localMessageType] as Any)

            } else {
                // We have a Data Message
                print("Data Message")

                var hasMessageDecoder = false
                var messageType: FitMessage!

                for message in messages {

                    if message.globalMessageNumber() == definitionDict[header.localMessageType]!.globalMessageNumber {
                        hasMessageDecoder = true
                        messageType = message.init()
                        break;
                    }
                }

                var fieldSize: Int = 0
                for msg in definitionDict[header.localMessageType]!.fieldDefinitions {
                    fieldSize = fieldSize + Int(msg.size)
                }

                let stdData = decoder.decodeData(length: fieldSize)

                var devSize: Int = 0
                for msg in definitionDict[header.localMessageType]!.developerFieldDefinitions {
                    devSize = devSize + Int(msg.size)
                }

                let devData = decoder.decodeData(length: devSize)

                let fieldData = FieldData(fieldData: stdData, developerFieldData: devData)

                if hasMessageDecoder == true {
                    let message = try messageType.decode(fieldData: fieldData, definition: definitionDict[header.localMessageType]!, dataStrategy: dataDecodingStrategy)
                    decoded?(message)
                    
                } else {
                    print("NO Decoder for type")

                }

            }

        } while decoder.index != messageData.count

    }
}


@available(swift 3.1)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
private extension FitFileDecoder {

    /// Reads File data and validates
    ///
    /// - Parameters:
    ///   - data: FIT File Data
    ///   - validateCrc: Should Validate CRC Values
    /// - Throws: FitError
    private mutating func readFitFile(data: Data, validateCrc: Bool) throws {

        let header = try FileHeader.decode(data: data, validateCrc: validateCrc)
        print(header)

        var decoder = DataDecoder(data)

        let _ = decoder.decodeData(length: Int(header.headerSize))

        let msgData = decoder.decodeData(length: Int(header.dataSize))

        let fileCrc = decoder.decodeUInt16()

        if validateCrc == true && header.protocolVersion >= 20 {
            let crcCheck = CRC16(data: msgData).crc

            guard fileCrc == crcCheck else { throw FitError(.invalidFileCrc) }
        }

        messageData = msgData
    }
}
