//
//  FitFileEncoder.swift
//  FitDataProtocol
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

/// FIT File Encoder
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
public struct FitFileEncoder {

    /// Options for Validity Strategy
    public enum ValidityStrategy {
        /// The default strategy assumes you know what type of Messages should be
        /// included with each type of file.
        case none
        /// File Type Checking
        ///
        /// This will check to make sure you have the correct Messages include for
        /// the file type indicated in the FileIdMessage.
        case fileType
        /// Garmin Connect Activity
        ///
        /// Garmin Connect reqiures some extra Messages in the Activity file type
        /// in order for it to be uploaded.
        case garminConnect
    }

    /// The strategy to use for Data Validity Strategy. Defaults to `.none`.
    public var dataValidityStrategy: ValidityStrategy

    /// Init FitFileEncoder
    ///
    /// - Parameter dataValidityStrategy: Validity Strategy
    public init(dataValidityStrategy: ValidityStrategy = .none) {
        self.dataValidityStrategy = dataValidityStrategy
    }
}

public extension FitFileEncoder {
        
    /// Encode FITFile
    ///
    /// - Parameters:
    ///   - fildIdMessage: FileID Message
    ///   - messages: Array of other FitMessages
    /// - Returns: Data Result
    func encode(fildIdMessage: FileIdMessage, messages: [FitMessage]) -> Result<Data, FitEncodingError> {

        func encodeDefHeader(index: UInt8, definition: DefinitionMessage) -> Data {
            var msgData = Data()

            let defHeader = RecordHeader(localMessageType: index, isDataMessage: false)
            msgData.append(defHeader.normalHeader)
            msgData.append(definition.encode())

            return msgData
        }

        guard messages.count > 0 else {
            return.failure(FitEncodingError.noMessages)
        }

        var msgData = Data()

        let validator = EncoderValidator.validate(fildIdMessage: fildIdMessage, messages: messages, dataValidityStrategy: dataValidityStrategy)
        switch validator {
        case .success(_):
            break
        case .failure(let error):
            return.failure(error)
        }

        var lastDefiniton: DefinitionMessage!
        
        switch fildIdMessage.encodeDefinitionMessage(fileType: fildIdMessage.fileType, dataValidityStrategy: dataValidityStrategy) {
        case .success(let definition):
            lastDefiniton = definition
        case .failure(let error):
            return.failure(error)
        }
        
        msgData.append(encodeDefHeader(index: 0, definition: lastDefiniton))

        switch fildIdMessage.encode(localMessageType: 0, definition: lastDefiniton) {
        case .success(let data):
            msgData.append(data)
        case .failure(let error):
            return.failure(error)
        }

        for message in messages {

            if message is FileIdMessage {
                return.failure(FitEncodingError.multipleFileIdMessage)
            }

            /// Endocde the Definition
            let def = message.encodeDefinitionMessage(fileType: fildIdMessage.fileType, dataValidityStrategy: dataValidityStrategy)
            switch def {
            case .success(let definition):
                if lastDefiniton != definition {
                    lastDefiniton = definition
                    msgData.append(encodeDefHeader(index: 0, definition: lastDefiniton))
                }
                
            case .failure(let error):
                return.failure(error)
            }

            /// Endode the Message
            switch message.encode(localMessageType: 0, definition: lastDefiniton) {
            case .success(let data):
                msgData.append(data)
            case .failure(let error):
                return.failure(error)
            }
        }

        if msgData.count > UInt32.max {
            return.failure(FitEncodingError.tooManyMessages)
        }

        let header = FileHeader(dataSize: UInt32(msgData.count))

        let dataCrc = CRC16(data: msgData).crc
        msgData.append(Data(from:dataCrc.littleEndian))

        var fileData = Data()
        fileData.append(header.encodedData)
        fileData.append(msgData)

        return.success(fileData)
    }

}
