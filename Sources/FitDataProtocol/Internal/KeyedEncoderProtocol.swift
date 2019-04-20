//
//  KeyedEncoderProtocol.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/19/19.
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

/// Protocol for Encoding FitMessage keys
internal protocol KeyedEncoder {
    func encodeKeyed(value: Bool) -> Result<Data, FitEncodingError>

    func encodeKeyed(value: UInt8) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: ValidatedBinaryInteger<UInt8>) -> Result<Data, FitEncodingError>

    func encodeKeyed(value: UInt16) -> Result<Data, FitEncodingError>

    func encodeKeyed(value: ValidatedBinaryInteger<UInt16>) -> Result<Data, FitEncodingError>

    func encodeKeyed(value: UInt32) -> Result<Data, FitEncodingError>

    func encodeKeyed(value: ValidatedBinaryInteger<UInt32>) -> Result<Data, FitEncodingError>

    func encodeKeyed(value: Double) -> Result<Data, FitEncodingError>
}

extension KeyedEncoder where Self: BaseTypeable {
    
    internal func encodeKeyed(value: Bool) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }
    
    internal func encodeKeyed(value: UInt8) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }
    
    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt8>) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }
    
    internal func encodeKeyed(value: UInt16) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }
    
    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt16>) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }
    
    internal func encodeKeyed(value: UInt32) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }
    
    internal func encodeKeyed(value: ValidatedBinaryInteger<UInt32>) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }
    
    internal func encodeKeyed(value: Double) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value, resolution: self.resolution)
    }
}

/// Protocol for Encoding FitMessage FitFile keys
internal protocol KeyedEncoderFitFile {
    func encodeKeyed(value: FileType) -> Result<Data, FitEncodingError>

    func encodeKeyed(value: FitFileFlag) -> Result<Data, FitEncodingError>
}

extension KeyedEncoderFitFile where Self: BaseTypeable {
    
    func encodeKeyed(value: FileType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: FitFileFlag) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
}


/// Protocol for Encoding FitMessage Sport keys
internal protocol KeyedEncoderSport {
    func encodeKeyed(value: Sport) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: SubSport) -> Result<Data, FitEncodingError>
}

extension KeyedEncoderSport where Self: BaseTypeable {
    
    func encodeKeyed(value: Sport) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: SubSport) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
}

/// Protocol for Encoding FitMessage Event Keys
internal protocol KeyedEncoderEvent {
    func encodeKeyed(value: Event) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: EventType) -> Result<Data, FitEncodingError>
}

extension KeyedEncoderEvent where Self: BaseTypeable {
    
    func encodeKeyed(value: Event) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: EventType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
}

/// Protocol for Encoding FitMessage Exercise Keys
internal protocol KeyedEncoderExercise {
    
    func encodeKeyed(value: ExerciseCategory) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: ExerciseNameType) -> Result<Data, FitEncodingError>
}

extension KeyedEncoderExercise where Self: BaseTypeable {
    
    func encodeKeyed(value: ExerciseCategory) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: ExerciseNameType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.number, resolution: self.resolution)
    }
}

/// Protocol for Encoding FitMessage Display Type Keys
internal protocol KeyedEncoderDisplayType {
    
    func encodeKeyed(value: MeasurementDisplayType) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: HeartRateDisplayType) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: PositionDisplayType) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: PowerDisplayType) -> Result<Data, FitEncodingError>
}

extension KeyedEncoderDisplayType where Self: BaseTypeable {

    func encodeKeyed(value: MeasurementDisplayType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: HeartRateDisplayType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: PositionDisplayType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: PowerDisplayType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
}

/// Protocol for Encoding FitMessage Ant Device Type Keys
internal protocol KeyedEncoderAntDevice {

    func encodeKeyed(value: DeviceType) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: BatteryStatus) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: BodyLocation) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: TransmissionType) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: NetworkType) -> Result<Data, FitEncodingError>
    
    func encodeKeyed(value: SourceType) -> Result<Data, FitEncodingError>
}

extension KeyedEncoderAntDevice where Self: BaseTypeable {

    func encodeKeyed(value: DeviceType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: BatteryStatus) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: BodyLocation) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: TransmissionType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: NetworkType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }
    
    func encodeKeyed(value: SourceType) -> Result<Data, FitEncodingError> {
        return self.baseType.encodedResolution(value: value.rawValue, resolution: self.resolution)
    }

}
