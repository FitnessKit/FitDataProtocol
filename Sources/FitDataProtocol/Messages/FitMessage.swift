//
//  FitMessage.swift
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
import FitnessUnits

/// Protocol for FIT Message Keys
public protocol FitMessageKeys {
    /// CodingKeys for FIT Message Type
    associatedtype FitCodingKeys: CodingKey
}

/// Base Class for FIT Messages
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class FitMessage {

    public required init() {}

    /// FIT Message Global Number
    public class func globalMessageNumber() -> UInt16 {
        fatalError("*** You must override in your class.")
    }

    internal func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> Self  {
        fatalError("*** You must override in your class.")
    }

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage
    /// - Throws: FitError
    internal func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws -> DefinitionMessage {
        throw FitError(.encodeError(msg: "Message not currently supported for Encode"))
        //fatalError("*** You must override in your class.")
    }

    /// Encodes the Message into Data
    ///
    /// - Parameters:
    ///   - localMessageType: Message Number, that matches the defintions header number
    ///   - definition: DefinitionMessage
    /// - Returns: Data representation
    /// - Throws: FitError
    internal func encode(localMessageType: UInt8, definition: DefinitionMessage) throws -> Data {
        throw FitError(.encodeError(msg: "Message not currently supported for Encode"))
        //fatalError("*** You must override in your class.")
    }

}

//MARK: - Standrd Decodes
internal extension FitMessage {

    /// Decode Int16
    ///
    /// - Parameters:
    ///   - decoder: Decoder
    ///   - endian: Endian
    ///   - data: Field Data
    /// - Returns: Decoded Int32
    internal func decodeInt16(decoder: inout DecodeData, endian: Endian, data: FieldData) -> Int16 {

        let value = endian == .little ? decoder.decodeInt16(data.fieldData).littleEndian : decoder.decodeInt16(data.fieldData).bigEndian

        return value
    }

    /// Decode UInt16
    ///
    /// - Parameters:
    ///   - decoder: Decoder
    ///   - endian: Endian
    ///   - data: Field Data
    /// - Returns: Decoded Int32
    internal func decodeUInt16(decoder: inout DecodeData, endian: Endian, data: FieldData) -> UInt16 {

        let value = endian == .little ? decoder.decodeUInt16(data.fieldData).littleEndian : decoder.decodeUInt16(data.fieldData).bigEndian

        return value
    }

    /// Decode Int32
    ///
    /// - Parameters:
    ///   - decoder: Decoder
    ///   - endian: Endian
    ///   - data: Field Data
    /// - Returns: Decoded Int32
    internal func decodeInt32(decoder: inout DecodeData, endian: Endian, data: FieldData) -> Int32 {

        let value = endian == .little ? decoder.decodeInt32(data.fieldData).littleEndian : decoder.decodeInt32(data.fieldData).bigEndian

        return value
    }

    /// Decode UInt32
    ///
    /// - Parameters:
    ///   - decoder: Decoder
    ///   - endian: Endian
    ///   - data: Field Data
    /// - Returns: Decoded Int32
    internal func decodeUInt32(decoder: inout DecodeData, endian: Endian, data: FieldData) -> UInt32 {

        let value = endian == .little ? decoder.decodeUInt32(data.fieldData).littleEndian : decoder.decodeUInt32(data.fieldData).bigEndian

        return value
    }

}

//MARK: - Preferred Values
internal extension FitMessage {

    /// Pick a Preferred Value for Power
    ///
    /// - Parameters:
    ///   - valueOne: Power Unit
    ///   - valueTwo: Power Unit
    /// - Returns: Preferred Power Unit
    internal func preferredPower(valueOne: ValidatedMeasurement<UnitPower>?, valueTwo: ValidatedMeasurement<UnitPower>?) -> ValidatedMeasurement<UnitPower>? {

        var power: ValidatedMeasurement<UnitPower>?

        /// Pick the First one
        /// it will be:
        /// - nil
        /// - contain a value
        power = valueOne

        if let value = valueTwo {

            // if the first value is not valid, but present
            // replace it no matter what
            if let v1 = valueOne {

                if v1.valid == false {
                    power = value
                } else {

                    // if v1 is valid and v2 is also valid
                    // replace it with v2
                    if value.valid {
                        power = value
                    }
                }

            } else {
                // if v1 is nil, just replace it with v2
                power = value
            }
        }

        return power
    }

    /// Pick a Preferred Value for Speed
    ///
    /// - Parameters:
    ///   - valueOne: Speed Unit
    ///   - valueTwo: Speed Unit
    /// - Returns: Preferred Speed Unit
    internal func preferredSpeed(valueOne: ValidatedMeasurement<UnitSpeed>?, valueTwo: ValidatedMeasurement<UnitSpeed>?) -> ValidatedMeasurement<UnitSpeed>? {

        var speed: ValidatedMeasurement<UnitSpeed>?

        /// Pick the First one
        /// it will be:
        /// - nil
        /// - contain a value
        speed = valueOne

        if let value = valueTwo {

            // if the first value is not valid, but present
            // replace it no matter what
            if let v1 = valueOne {

                if v1.valid == false {
                    speed = value
                } else {

                    // if v1 is valid and v2 is also valid
                    // replace it with v2
                    if value.valid {
                        speed = value
                    }
                }

            } else {
                // if v1 is nil, just replace it with v2
                speed = value
            }
        }

        return speed
    }

    /// Pick a Preferred Value for Length
    ///
    /// - Parameters:
    ///   - valueOne: Length Unit
    ///   - valueTwo: Length Unit
    /// - Returns: Preferred Length Unit
    internal func preferredLength(valueOne: ValidatedMeasurement<UnitLength>?, valueTwo: ValidatedMeasurement<UnitLength>?) -> ValidatedMeasurement<UnitLength>? {

        var length: ValidatedMeasurement<UnitLength>?

        /// Pick the First one
        /// it will be:
        /// - nil
        /// - contain a value
        length = valueOne

        if let value = valueTwo {

            // if the first value is not valid, but present
            // replace it no matter what
            if let v1 = valueOne {

                if v1.valid == false {
                    length = value
                } else {

                    // if v1 is valid and v2 is also valid
                    // replace it with v2
                    if value.valid {
                        length = value
                    }
                }

            } else {
                // if v1 is nil, just replace it with v2
                length = value
            }
        }

        return length
    }
}
