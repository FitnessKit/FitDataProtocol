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


    public static func encode(fildIdMessage: FileIdMessage, messages: [FitMessage]) throws -> Data {

        guard messages.count > 0 else {
            throw FitError(.encodeError(msg: "No Messages to Encode"))
        }
        
        var msgData = Data()

        msgData.append(try fildIdMessage.encode())

        for message in messages {

            if message is FileIdMessage {
                throw FitError(.encodeError(msg: "messages can not contain second FileIdMessage"))
            }

            msgData.append(try message.encode())

        }

        if msgData.count > UInt32.max {
            throw FitError(.encodeError(msg: "Fit File has to many Messages. Can only encode \(UInt32.max) bytes"))
        }

        let dataCrc = CRC16(data: msgData).crc
        msgData.append(Data(from:dataCrc.littleEndian))

        let header = FileHeader(dataSize: UInt32(msgData.count))
        print(header.encodedData as NSData)

        var fileData = Data()
        fileData.append(header.encodedData)
        fileData.append(msgData)

        return fileData
    }
}
