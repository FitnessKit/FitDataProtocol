//
//  FitFileMerger.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/9/18.
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

/// FIT File Merger
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
public struct FitFileMerger {

    private struct MergeFile {

        /// File Header
        let header: FileHeader

        let messageData: Data

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (lhs: MergeFile, rhs: MergeFile) -> Bool {
            return (lhs.header == rhs.header) &&
                (lhs.messageData == rhs.messageData)
        }

    }

    /// Options for CRC Checking
    public enum CrcCheckingStrategy {
        /// Throw upon encountering invalid CRCs. This is the default strategy.
        case `throws`
        /// Don't Check CRC Values
        case ignore
    }

    /// The strategy to use for CRC Checking. Defaults to `.throws`.
    public var crcCheckingStrategy: CrcCheckingStrategy

    /// Options for Data Merging
    public enum DataMergingStrategy {
        /// Merge using default strategy
        case `default`
    }

    /// The strategy to use for Data Merging. Defaults to `.default`.
    public var dataMergingStrategy: DataMergingStrategy


    public init(crcCheckingStrategy: CrcCheckingStrategy = .throws, dataMergingStrategy: DataMergingStrategy = .default) {
        self.crcCheckingStrategy = crcCheckingStrategy
        self.dataMergingStrategy = dataMergingStrategy
    }
}

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
public extension FitFileMerger {

    public func merge(files: [Data]) throws -> Data {

        var fitFiles: [MergeFile] = [MergeFile]()

        var shouldValidate: Bool = true
        switch crcCheckingStrategy {
        case .ignore:
            shouldValidate = false
        default:
            shouldValidate = true
        }

        // Step 1.  Get all Files and Check for CRC if requested
        for fitfile in files {
            let header = try FileHeader.decode(data: fitfile, validateCrc: shouldValidate)
            //print(header)

            var decoder = DataDecoder(fitfile)

            let _ = decoder.decodeData(length: Int(header.headerSize))

            let msgData = decoder.decodeData(length: Int(header.dataSize))

            let fileCrc = decoder.decodeUInt16()

            if shouldValidate == true && header.protocolVersion >= 20 {
                let crcCheck = CRC16(data: msgData).crc
                guard fileCrc == crcCheck else { throw FitError(.invalidFileCrc) }
            }

            let newFile = MergeFile(header: header, messageData: msgData)
            fitFiles.append(newFile)
        }

        // Step 2.  Check if the FIT Versions match
        guard let firstHeader = fitFiles.first?.header else {
            throw FitError(.generic("Error With Fit Files"))
        }

        var dataSize: UInt32 = 0
        var mergedMsgData: Data = Data()

        if dataMergingStrategy == .default {

            for file in fitFiles {
                if ProtocolVersionMajor(file.header.protocolVersion) != ProtocolVersionMajor(firstHeader.protocolVersion) {
                    throw FitError(.generic("Protocol Version Mismatch during merge."))
                }
                dataSize = dataSize + UInt32(file.messageData.count)
                mergedMsgData.append(file.messageData)
            }
        }

        let newHeader = FileHeader(dataSize: dataSize)

        var fileData = Data()
        fileData.append(newHeader.encodedData)
        fileData.append(mergedMsgData)

        let crcCheck = CRC16(data: mergedMsgData).crc
        fileData.append(Data(from:crcCheck.littleEndian))

        return fileData
    }
}

