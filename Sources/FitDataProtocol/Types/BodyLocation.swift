//
//  BodyLocation.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/4/18.
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

/// Body Location
public enum BodyLocation: UInt8 {
    /// Left Leg
    case leftLeg                = 0
    /// Left Calf
    case leftCalf               = 1
    /// Left Shin
    case leftShin               = 2
    /// Left Hamstring
    case leftHamstring          = 3
    /// Left Quad
    case leftQuad               = 4
    /// Left Glute
    case leftGlute              = 5
    /// Right Leg
    case rightLeg               = 6
    /// Right Calf
    case rightCalf              = 7
    /// Right Shin
    case rightShin              = 8
    /// Right Hamstring
    case rightHamstring         = 9
    /// Right Quad
    case rightQuad              = 10
    /// Right Glute
    case rightGlute             = 11
    /// Torso Back
    case torsoBack              = 12
    /// Left Lower Back
    case leftLowerBack          = 13
    /// Left Upper Back
    case leftUpperBack          = 14
    /// Right Lower Back
    case rightLowerBack         = 15
    /// Right Upper Back
    case rightUpperBack         = 16
    /// Torso Front
    case torsoFront             = 17
    /// Left Abdomen
    case leftAbdomen            = 18
    /// Left Chest
    case leftChest              = 19
    /// Right Abdomen
    case rightAbdomen           = 20
    /// Right Chest
    case rightChest             = 21
    /// Left Arm
    case leftArm                = 22
    /// Left Shoulder
    case leftShoulder           = 23
    /// Left Bicep
    case leftBicep              = 24
    /// Left Tricep
    case leftTricep             = 25
    /// Left anterior forearm
    case leftAnteriorForearm    = 26
    /// Left posterior forearm
    case leftPosteriorForearm   = 27
    /// Right Arm
    case rightArm               = 28
    /// Right Shoulder
    case rightShoulder          = 29
    /// Right Bicep
    case rightBicep             = 30
    /// Right Tricep
    case rightTricep            = 31
    /// Right anterior forearm
    case rightAnteriorForearm   = 32
    /// Right posterior forearm
    case rightPosteriorForearm  = 33
    /// Neck
    case neck                   = 34
    /// Throat
    case throat                 = 35
    /// Waist Mid Back
    case waistMidBack           = 36
    /// Waist Front
    case waistFront             = 37
    /// Waist Left
    case waistLeft              = 38
    /// Waist Right
    case waistRight             = 39

    /// Invalid
    case invalid                = 255
}

// MARK: - FitFieldCodeable
extension BodyLocation: FitFieldCodeable {
    
    /// Encode Into Data
    /// - Parameter base: BaseTypeData
    public func encode(base: BaseTypeData) -> Data? {
        Data(from: self.rawValue.littleEndian)
    }
    
    /// Decode FIT Field
    ///
    /// - Parameters:
    ///   - type: Type of Field
    ///   - data: Data to Decode
    ///   - base: BaseTypeData
    ///   - arch: Endian
    /// - Returns: Decoded Value
    public static func decode<T>(type: T.Type, data: Data, base: BaseTypeData, arch: Endian) -> T? {
        if let value = base.type.decode(type: UInt8.self, data: data, resolution: base.resolution, arch: arch) {
            return BodyLocation(rawValue: value) as? T
        }
        
        return nil
    }
}
