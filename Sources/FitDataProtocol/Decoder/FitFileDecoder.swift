//
//  FitFileDecoder.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/21/18.
//

import Foundation
import DataDecoder

/// FIT File Decoder
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
public struct FitFileDecoder {
    private var messageData: Data
    private var lastDefinition: DefinitionMessage!
    private var definitionDict: [UInt8 : DefinitionMessage]

    /// Default FIT Messages for Decoding
    public static let defaultMessages = [FileIdMessage.self,
                                         RecordMessage.self,
                                         EventMessage.self,
                                         ActivityMessage.self,
                                         FileCreatorMessage.self,
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

    public init(crcDecodingStrategy: CrcDecodingStrategy = .throws) {
        self.crcDecodingStrategy = crcDecodingStrategy
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
                lastDefinition = try DefinitionMessage.decode(decoder: &decoder, header: header)
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

                let fieldData = decoder.decodeData(length: fieldSize)

                var devSize: Int = 0
                for msg in definitionDict[header.localMessageType]!.developerFieldDefinitions {
                    devSize = devSize + Int(msg.size)
                }

                let _ = decoder.decodeData(length: devSize)


                if hasMessageDecoder == true {
                    let message = try messageType.decode(fieldData: fieldData, definition: definitionDict[header.localMessageType]!)
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
