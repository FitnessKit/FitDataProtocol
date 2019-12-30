//
//  DefinitionMessage.swift
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

/// Architecture Endian
public enum Endian: UInt8 {
    /// Little
    case little     = 0
    /// Big
    case big        = 1
}

/// FIT Definition Message
internal struct DefinitionMessage {

    /// Architecture
    private(set) var architecture: Endian

    /// Global Message Number
    private(set) var globalMessageNumber: UInt16

    /// Number of Fields
    private(set) var fields: UInt8

    /// Field Definitions
    private(set) var fieldDefinitions: [FieldDefinition]

    /// Developer Field Definitions
    private(set) var developerFieldDefinitions: [DeveloperFieldDefinition]

}

extension DefinitionMessage: Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    internal static func == (lhs: DefinitionMessage, rhs: DefinitionMessage) -> Bool {
        return (lhs.architecture == rhs.architecture) &&
            (lhs.globalMessageNumber == rhs.globalMessageNumber) &&
            (lhs.fields == rhs.fields) &&
            (lhs.fieldDefinitions == rhs.fieldDefinitions) &&
            (lhs.developerFieldDefinitions == rhs.developerFieldDefinitions)
    }
}

internal extension DefinitionMessage {

    /// Encodes the DefinitionMessage into Data
    ///
    /// - Returns: Data representation
    func encode() -> Data {
        var msgData = Data()

        msgData.append(UInt8(0))
        msgData.append(architecture.rawValue)
        msgData.append(Data(from: globalMessageNumber.littleEndian))
        msgData.append(fields)

        for fieldDef in fieldDefinitions {
            msgData.append(fieldDef.encode())
        }

        return msgData
    }

    static func decode(decoder: inout DecodeData, data: Data, header: RecordHeader) -> Result<DefinitionMessage, FitDecodingError>  {

        // Reserved Byte
        let _ = decoder.decodeUInt8(data)

        let archvalue = decoder.decodeUInt8(data)

        guard let architecture = Endian(rawValue: archvalue) else { return.failure(FitDecodingError.invalidArchitecture) }

        var globalMessage = decoder.decodeUInt16(data)

        switch architecture {
        case .little:
            globalMessage = globalMessage.littleEndian
        case .big:
            globalMessage = globalMessage.bigEndian
        }

        let fields = decoder.decodeUInt8(data)

        var definitions: [FieldDefinition] = [FieldDefinition]()

        for _ in 0..<fields {
            
            switch FieldDefinition.decode(decoder: &decoder, data: data) {
            case .success(let fieldDef):
                definitions.append(fieldDef)
            case .failure(let error):
                return.failure(error)
            }
        }

        var devDefinitions: [DeveloperFieldDefinition] = [DeveloperFieldDefinition]()
        if header.developerData == true {
            let devFields = decoder.decodeUInt8(data)

            for _ in 0..<devFields {

                switch DeveloperFieldDefinition.decode(decoder: &decoder, data: data) {
                case .success(let devField):
                    devDefinitions.append(devField)
                case .failure(let error):
                    return.failure(error)
                }
            }
        }

        let definition =  DefinitionMessage(architecture: architecture,
                                            globalMessageNumber: globalMessage,
                                            fields: fields,
                                            fieldDefinitions: definitions,
                                            developerFieldDefinitions: devDefinitions)
        
        return.success(definition)
    }
}
