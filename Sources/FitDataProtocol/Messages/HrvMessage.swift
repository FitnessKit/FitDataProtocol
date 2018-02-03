//
//  HrvMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 2/3/18.
//

import Foundation
import DataDecoder

/// FIT HRV Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class HrvMessage: FitMessage {

    public override class func globalMessageNumber() -> UInt16 {
        return 78
    }

    /// Heart Rate Variability
    private(set) public var hrv: [Measurement<UnitDuration>]?

    public required init() {}

    public init(hrv: [Measurement<UnitDuration>]?) {
        self.hrv = hrv
    }

    internal override func decode(fieldData: Data, definition: DefinitionMessage) throws -> HrvMessage  {

        var hrv: [Measurement<UnitDuration>]?

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

                case .time:
                    let timeData = localDecoder.decodeData(length: Int(definition.size))
                    print(timeData.count)

                    var localDecoder = DataDecoder(timeData)

                    var seconds = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian

                    while seconds != 0 {
                        let interval = Measurement(value: (Double(seconds) / 1024), unit: UnitDuration.seconds)

                        if hrv == nil {
                            hrv = [Measurement<UnitDuration>]()
                        }
                        hrv?.append(interval)

                        seconds = arch == .little ? localDecoder.decodeUInt16().littleEndian : localDecoder.decodeUInt16().bigEndian
                    }


                }
            }
        }

        return HrvMessage()
    }
}

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension HrvMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    public enum MessageKeys: Int, CodingKey {
        case time       = 0
    }
}
