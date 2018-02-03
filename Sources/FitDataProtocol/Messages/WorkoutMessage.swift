//
//  WorkoutMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/28/18.
//

import Foundation
import DataDecoder

/// FIT Workout Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WorkoutMessage: FitMessage, FitMessageKeys {

    public override class func globalMessageNumber() -> UInt16 {
        return 26
    }

    public enum MessageKeys: Int, CodingKey {
        case sport                  = 4
        case capabilities           = 5
        case numberOfValidSteps     = 6
        case workoutName            = 8
        case subSport               = 11
        case poolLength             = 14
        case poolLenghtUnit         = 15
    }

    public typealias FitCodingKeys = MessageKeys

    /// Workout Name
    private(set) public var workoutName: String?

    /// Number of Valid Steps
    private(set) public var numberOfValidSteps: UInt16?

    /// Pool Length
    private(set) public var poolLength: Measurement<UnitLength>?

    /// Pool Lenght Unit
    private(set) public var poolLenghtUnit: MeasurementDisplayType?

    /// Sport
    private(set) public var sport: Sport?

    /// Sub Sport
    private(set) public var subSport: SubSport?

    public required init() {}

    public init(workoutName: String?, numberOfValidSteps: UInt16?, poolLength: Measurement<UnitLength>?, poolLenghtUnit: MeasurementDisplayType?, sport: Sport?, subSport: SubSport?) {
        self.workoutName = workoutName
        self.numberOfValidSteps = numberOfValidSteps
        self.poolLength = poolLength
        self.poolLenghtUnit = poolLenghtUnit
        self.sport = sport
        self.subSport = subSport
    }

    internal override func decode(fieldData: Data, definition: DefinitionMessage) throws -> WorkoutMessage  {

        var workoutName: String?
        var numberOfValidSteps: UInt16?
        var poolLength: Measurement<UnitLength>?
        var poolLenghtUnit: MeasurementDisplayType?
        var sport: Sport?
        var subSport: SubSport?

        let arch = definition.architecture

        var localDecoder = DataDecoder(fieldData)

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(length: Int(definition.size))
                print("Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .sport:
                    let value = localDecoder.decodeUInt8()
                    sport = Sport(rawValue: value)

                case .capabilities:
                    // We still need to pull this data off the stack
                    let _ = localDecoder.decodeData(length: Int(definition.size))

                case .numberOfValidSteps:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        numberOfValidSteps = value
                    }

                case .workoutName:
                    // We still need to pull this data off the stack
                    let stringData = localDecoder.decodeData(length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        workoutName = stringData.smartString
                    }

                case .subSport:
                    let value = localDecoder.decodeUInt8()
                    subSport = SubSport(rawValue: value)

                case .poolLength:
                    let value = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        //  100 * m + 0
                        let value = Double(value) / 100
                        poolLength = Measurement(value: value, unit: UnitLength.meters)
                    }

                case .poolLenghtUnit:
                    let value = localDecoder.decodeUInt8()
                    poolLenghtUnit = MeasurementDisplayType(rawValue: value)

                }
            }
        }

        return WorkoutMessage(workoutName: workoutName,
                              numberOfValidSteps: numberOfValidSteps,
                              poolLength: poolLength,
                              poolLenghtUnit: poolLenghtUnit,
                              sport: sport,
                              subSport: subSport)
    }
}
