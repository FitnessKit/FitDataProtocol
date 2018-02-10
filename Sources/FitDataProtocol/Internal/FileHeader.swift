//
//  FileHeader.swift
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

public let kProtocolVersionMajor: UInt8 = 20
public let kProtocolVersionMinor: UInt8 = 54

internal func ProtocolVersionMajor(_ value: UInt8) -> UInt8 {
    return (value >> 4)
}

internal var protocolVersion20: UInt8 {
    return (2 << 4) | 0
}


internal struct FileHeader {

    /// Size of Header
    private(set) public var headerSize: UInt8

    /// Protocol version number as provided in SDK
    private(set) public var protocolVersion: UInt8

    /// Profile version number as provided in SDK
    private(set) public var profileVersion: UInt16

    /// Data Size
    private(set) public var dataSize: UInt32

    /// CRC Value
    private(set) public var crc: UInt16?

    internal init(dataSize: UInt32) {
        self.headerSize = 14
        self.protocolVersion = protocolVersion20
        self.profileVersion = 2054
        self.dataSize = dataSize
        self.crc = 0
    }

    private init(headerSize: UInt8, protocolVersion: UInt8, profileVersion: UInt16, dataSize: UInt32, crc: UInt16?) {
        self.headerSize = headerSize
        self.protocolVersion = protocolVersion
        self.profileVersion = profileVersion
        self.dataSize = dataSize
        self.crc = crc
    }
}

extension FileHeader: Equatable {

    internal static func == (lhs: FileHeader, rhs: FileHeader) -> Bool {
        return (lhs.headerSize == rhs.headerSize) &&
            (lhs.protocolVersion == rhs.protocolVersion) &&
            (lhs.profileVersion == rhs.profileVersion) &&
            (lhs.dataSize == rhs.dataSize) &&
            (lhs.crc == rhs.crc)
    }
}

internal extension FileHeader {

    internal var encodedData: Data {
        var encode = Data()

        encode.append(headerSize)
        encode.append(protocolVersion)
        encode.append(Data(from: profileVersion.littleEndian))
        encode.append(Data(from: dataSize.littleEndian))
        encode.append(46)
        encode.append(70)
        encode.append(73)
        encode.append(84)

        if headerSize == 14 {
            let crcCheck = CRC16(data: encode).crc
            encode.append(Data(from:crcCheck.littleEndian))
        }
        return encode
    }
}

internal extension FileHeader {

    internal static func decode(data: Data, validateCrc: Bool = true) throws -> FileHeader {
        var decoder = DataDecoder(data)

        let headerSize = decoder.decodeUInt8()

        guard headerSize <= data.count else { throw FitError(message: "Header Size mismatch") }

        let protocolVersion = decoder.decodeUInt8()

        guard ProtocolVersionMajor(protocolVersion) <= ProtocolVersionMajor(protocolVersion20) else { throw FitError(.protocolVersionNotSupported) }

        let profileVersion = decoder.decodeUInt16()
        let dataSize = decoder.decodeUInt32()

        let fitCheckData = decoder.decodeData(length: 4)
        let fitString = String(bytes: fitCheckData, encoding: .ascii)

        guard fitString == ".FIT" else { throw FitError(.nonFitFile) }

        // If we have a size of 14 in Header check CRC
        var crc: UInt16?
        if headerSize == 14 {
            let crcValue = decoder.decodeUInt16()

            if crcValue != 0 {
                crc = crcValue

                if validateCrc == true {
                    let crcData = data[0...11]

                    let value = CRC16(data: crcData).crc

                    guard value == crc else { throw FitError(.invalidHeaderCrc) }
                }
            }
        }

        return FileHeader(headerSize: headerSize,
                          protocolVersion: protocolVersion,
                          profileVersion: profileVersion,
                          dataSize: dataSize,
                          crc: crc)
    }
}

