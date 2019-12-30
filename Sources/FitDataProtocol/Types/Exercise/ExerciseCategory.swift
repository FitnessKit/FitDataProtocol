//
//  ExerciseCategory.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/3/18.
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

/// Exercise Category
public enum ExerciseCategory: UInt16 {
    /// Bench Press
    case benchPress         = 0
    /// Calf Raise
    case calfRaise          = 1
    /// Cardio
    case cardio             = 2
    /// Carry
    case carry              = 3
    /// Chop
    case chop               = 4
    /// Core
    case core               = 5
    /// Crunch
    case crunch             = 6
    /// Curl
    case curl               = 7
    /// Deadlift
    case deadlift           = 8
    /// Flye
    case flye               = 9
    /// Hip Raise
    case hipRaise           = 10
    /// Hip Stability
    case hipStability       = 11
    /// Hip Swing
    case hipSwing           = 12
    /// Hyper Extension
    case hyperExtension     = 13
    /// Lateral Raise
    case lateralRaise       = 14
    /// Leg Curl
    case legCurl            = 15
    /// Leg Raise
    case legRaise           = 16
    /// Lunge
    case lunge              = 17
    /// Olympic Lift
    case olympicLift        = 18
    /// Plank
    case plank              = 19
    /// Plyo
    case plyo               = 20
    /// Pull Up
    case pullUp             = 21
    /// Push Up
    case pushUp             = 22
    /// Row
    case row                = 23
    /// Shoulder Press
    case shoulderPress      = 24
    //// Shoulder Stability
    case shoulderStability  = 25
    /// Shrug
    case shrug              = 26
    /// Sit Up
    case sitUp              = 27
    /// Squat
    case squat              = 28
    /// Total Body
    case totalBody          = 29
    //// Triceps Extension
    case tricepExtension    = 30
    /// Warm Up
    case warmUp             = 31
    /// Run
    case run                = 32

    /// Unknown
    case unknown            = 65534
    /// Invalid
    case invalid            = 65535
}

// MARK: - FitFieldCodeable
extension ExerciseCategory: FitFieldCodeable {
    
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
        if let value = base.type.decode(type: UInt16.self, data: data, resolution: base.resolution, arch: arch) {
            return ExerciseCategory(rawValue: value) as? T
        }
        
        return nil
    }
}

internal extension ExerciseCategory {

    /// Gets the Valid Exercise Name Type
    var validExerciseNameType: ExerciseNameType.Type? {
        switch self {
        case .benchPress:
            return BenchPressExerciseName.self
        case .calfRaise:
            return CalfRaiseExerciseName.self
        case .cardio:
            return CardioExerciseName.self
        case .carry:
            return CarryExerciseName.self
        case .chop:
            return ChopExerciseName.self
        case .core:
            return CoreExerciseName.self
        case .crunch:
            return CrunchExerciseName.self
        case .curl:
            return CurlExerciseName.self
        case .deadlift:
            return DeadliftExerciseName.self
        case .flye:
            return FlyeExerciseName.self
        case .hipRaise:
            return HipRaiseExerciseName.self
        case .hipStability:
            return HipStabilityExerciseName.self
        case .hipSwing:
            return HipSwingExerciseName.self
        case .hyperExtension:
            return HyperextensionExerciseName.self
        case .lateralRaise:
            return LateralRaiseExerciseName.self
        case .legCurl:
            return LegCurlExerciseName.self
        case .legRaise:
            return LegRaiseExerciseName.self
        case .lunge:
            return LungeExerciseName.self
        case .olympicLift:
            return OlympicLiftExerciseName.self
        case .plank:
            return PlankExerciseName.self
        case .plyo:
            return PlyoExerciseName.self
        case .pullUp:
            return PullUpExerciseName.self
        case .pushUp:
            return PushUpExerciseName.self
        case .row:
            return RowExerciseName.self
        case .shoulderPress:
            return ShoulderPressExerciseName.self
        case .shoulderStability:
            return ShoulderStabilityExerciseName.self
        case .shrug:
            return ShrugExerciseName.self
        case .sitUp:
            return SitUpExerciseName.self
        case .squat:
            return SquatExerciseName.self
        case .totalBody:
            return TotalBodyExerciseName.self
        case .tricepExtension:
            return TricepExtensionExerciseName.self
        case .warmUp:
            return WarmUpExerciseName.self
        case .run:
            return RunExerciseName.self

        case .unknown:
            return nil
        case .invalid:
            return nil
        }
    }
}

internal extension ExerciseCategory {

    func exerciseName(from: UInt16) -> ExerciseNameType? {
        return validExerciseNameType?.create(rawValue: from)
    }
}
