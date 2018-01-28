//
//  FileHeader.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/27/18.
//

import Foundation
import DataDecoder

public let kProtocolVersionMajor: UInt8 = 20
public let kProtocolVersionMinor: UInt8 = 54

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
        self.protocolVersion = 23  // 2.3
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

internal extension FileHeader {

    internal static func decode(data: Data, validateCrc: Bool = true) throws -> FileHeader {
        var decoder = DataDecoder(data)

        let headerSize = decoder.decodeUInt8()

        guard headerSize <= data.count else { throw FitError(message: "Header Size mismatch") }

        let protocolVersion = decoder.decodeUInt8()

        guard protocolVersion >> 4 <= kProtocolVersionMajor else { throw FitError(.protocolVersionNotSupported) }

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
            }

            if validateCrc == true {
                let crcData = data[0...11]

                let value = CRC16(data: crcData).crc

                guard value == crc else { throw FitError(.invalidHeaderCrc) }
            }
        }

        return FileHeader(headerSize: headerSize,
                          protocolVersion: protocolVersion,
                          profileVersion: profileVersion,
                          dataSize: dataSize,
                          crc: crc)
    }
}

