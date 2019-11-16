//
//  FileCapabilitiesMessageKeys.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 8/25/18.
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
import AntMessageProtocol
import FitnessUnits

@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension FileCapabilitiesMessage: FitMessageKeys {
    /// CodingKeys for FIT Message Type
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    public enum MessageKeys: Int, CodingKey, CaseIterable {
        /// Message Index
        case messageIndex       = 254

        /// File Type
        case fileType           = 0
        /// File Flags
        case fileFlags          = 1
        /// Directory
        case directory          = 2
        /// Max Count
        case maxCount           = 3
        /// Max Size
        case maxSize            = 4
    }
}

extension FileCapabilitiesMessage.FitCodingKeys: BaseTypeable {
    /// Key Base Type
    var baseType: BaseType { return self.baseData.type }
    
    /// Key Base Data
    var baseData: BaseTypeData {
        switch self {
        case .messageIndex:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
            
        case .fileType:
            return BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .fileFlags:
            return BaseTypeData(type: .uint8z, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .directory:
            // 16
            return BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .maxCount:
            return BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0))
        case .maxSize:
            return BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0))
        }
    }
}

extension FileCapabilitiesMessage.FitCodingKeys: KeyedEncoder {}

// FitFile Encoding
extension FileCapabilitiesMessage.FitCodingKeys: KeyedEncoderFitFile {}


extension FileCapabilitiesMessage.FitCodingKeys: KeyedFieldDefintion {
    /// Raw Value for CodingKey
    var keyRawValue: Int { return self.rawValue }
}
