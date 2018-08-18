//
//  WeatherAlertMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 4/29/18.
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
import AntMessageProtocol

/// FIT Weather Alert Message
@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WeatherAlertMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 129
    }

    /// Timestamp
    private(set) public var timeStamp: FitTime?

    /// Report ID
    ///
    /// Unique identifier from GCS report ID
    private(set) public var reportID: String?

    /// Issue Time
    ///
    /// Time alert was issued
    private(set) public var issueTime: FitTime?

    /// Expire Time
    ///
    /// Time alert expires
    private(set) public var expireTime: FitTime?

    /// Weather Severity
    private(set) public var severity: WeatherSeverity?

    /// Alert Type
    private(set) public var alertType: WeatherSeverityType?


    public required init() {}

    public init(timeStamp: FitTime?,
                reportID: String?,
                issueTime: FitTime?,
                expireTime: FitTime?,
                severity: WeatherSeverity?,
                alertType: WeatherSeverityType?) {
        
        self.timeStamp = timeStamp
        self.reportID = reportID
        self.issueTime = issueTime
        self.expireTime = expireTime
        self.severity = severity
        self.alertType = alertType

    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> WeatherAlertMessage  {

        var timeStamp: FitTime?
        var reportID: String?
        var issueTime: FitTime?
        var expireTime: FitTime?
        var severity: WeatherSeverity?
        var alertType: WeatherSeverityType?

        let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("TotalsMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .reportId:
                    let stringData = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                    if UInt64(stringData.count) != definition.baseType.invalid {
                        reportID = stringData.smartString
                    }

                case .issueTime:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        issueTime = FitTime(time: value)
                    }

                case .expireTime:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        expireTime = FitTime(time: value)
                    }

                case .severity:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        severity = WeatherSeverity(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            severity = WeatherSeverity.invalid
                        }
                    }

                case .alertType:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if UInt64(value) != definition.baseType.invalid {
                        alertType = WeatherSeverityType(rawValue: value)
                    } else {

                        switch dataStrategy {
                        case .nil:
                            break
                        case .useInvalid:
                            alertType = WeatherSeverityType.invalid
                        }
                    }

                case .timestamp:
                    let value = arch == .little ? localDecoder.decodeUInt32(fieldData.fieldData).littleEndian : localDecoder.decodeUInt32(fieldData.fieldData).bigEndian
                    if UInt64(value) != definition.baseType.invalid {
                        timeStamp = FitTime(time: value)
                    }

                }

            }
        }

        return WeatherAlertMessage(timeStamp: timeStamp,
                                   reportID: reportID,
                                   issueTime: issueTime,
                                   expireTime: expireTime,
                                   severity: severity,
                                   alertType: alertType)
    }

}

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension WeatherAlertMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    ///
    public enum MessageKeys: Int, CodingKey {
        case reportId           = 0
        case issueTime          = 1
        case expireTime         = 2
        case severity           = 3
        case alertType          = 4

        case timestamp          = 253
    }
}
