//
//  ConnectivityMessage.swift
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

/// FIT Slave Device Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class ConnectivityMessage: FitMessage {

    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 {
        return 127
    }

    /// Bluetooth Enabled
    private(set) public var bluetoothEnabled: Bool?

    /// Bluetooth Low Energy Enabled
    private(set) public var bluetoothLowEnergyEnable: Bool?

    /// ANT Enabled
    private(set) public var antEnabled: Bool?

    /// Live Tracking Enabled
    private(set) public var liveTrackingEnabled: Bool?

    /// Weather Conditions Enabled
    private(set) public var weatherConditionsEnabled: Bool?

    /// Weather Alerts Enabled
    private(set) public var weatherAlertsEnabled: Bool?

    /// Auto Activity Upload Enabled
    private(set) public var autoActivityUploadEnabled: Bool?

    /// Course Download Enabled
    private(set) public var courseDownloadEnabled: Bool?

    /// Workout Download Enabled
    private(set) public var workoutDownloadEnabled: Bool?

    /// GPS Ephemeris Download Enabled
    private(set) public var gpsEphemerisDownloadEnabled: Bool?

    /// Incident Detection Enabled
    private(set) public var incidentDetectionEnabled: Bool?

    /// Group Tracking Enabled
    private(set) public var groupTrackEnabled: Bool?

    /// Connectivity Name
    private(set) public var name: String?

    public required init() {}

    public init(bluetoothEnabled: Bool?,
                bluetoothLowEnergyEnable: Bool?,
                antEnabled: Bool?,
                name: String?,
                liveTrackingEnabled: Bool?,
                weatherConditionsEnabled: Bool?,
                weatherAlertsEnabled: Bool?,
                autoActivityUploadEnabled: Bool?,
                courseDownloadEnabled: Bool?,
                workoutDownloadEnabled: Bool?,
                gpsEphemerisDownloadEnabled: Bool?,
                incidentDetectionEnabled: Bool?,
                groupTrackEnabled: Bool?) {

        self.bluetoothEnabled = bluetoothEnabled
        self.bluetoothLowEnergyEnable = bluetoothLowEnergyEnable
        self.antEnabled = antEnabled
        self.name = name
        self.liveTrackingEnabled = liveTrackingEnabled
        self.weatherConditionsEnabled = weatherConditionsEnabled
        self.weatherAlertsEnabled = weatherAlertsEnabled
        self.autoActivityUploadEnabled = autoActivityUploadEnabled
        self.courseDownloadEnabled = courseDownloadEnabled
        self.workoutDownloadEnabled = workoutDownloadEnabled
        self.gpsEphemerisDownloadEnabled = gpsEphemerisDownloadEnabled
        self.groupTrackEnabled = groupTrackEnabled
    }

    internal override func decode(fieldData: FieldData, definition: DefinitionMessage, dataStrategy: FitFileDecoder.DataDecodingStrategy) throws -> ConnectivityMessage  {

        var bluetoothEnabled: Bool?
        var bluetoothLowEnergyEnable: Bool?
        var antEnabled: Bool?
        var liveTrackingEnabled: Bool?
        var weatherConditionsEnabled: Bool?
        var weatherAlertsEnabled: Bool?
        var autoActivityUploadEnabled: Bool?
        var courseDownloadEnabled: Bool?
        var workoutDownloadEnabled: Bool?
        var gpsEphemerisDownloadEnabled: Bool?
        var incidentDetectionEnabled: Bool?
        var groupTrackEnabled: Bool?
        var name: String?

        //let arch = definition.architecture

        var localDecoder = DecodeData()

        for definition in definition.fieldDefinitions {

            let key = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch key {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("ConnectivityMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let converter):
                switch converter {

                case .bluetoothEnabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        bluetoothEnabled = value.boolValue
                    }

                case .bluetoothLowEnergyEnable:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        bluetoothLowEnergyEnable = value.boolValue
                    }

                case .antEnabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        antEnabled = value.boolValue
                    }

                case .connectivityName:
                    name = String.decode(decoder: &localDecoder,
                                         definition: definition,
                                         data: fieldData,
                                         dataStrategy: dataStrategy)

                case .liveTrackingEnabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        liveTrackingEnabled = value.boolValue
                    }

                case .weatherConditionsEnabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        weatherConditionsEnabled = value.boolValue
                    }

                case .weatherAlertsEnabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        weatherAlertsEnabled = value.boolValue
                    }

                case .autoActivityUploadEnabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        autoActivityUploadEnabled = value.boolValue
                    }

                case .courseDownloadEnabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        courseDownloadEnabled = value.boolValue
                    }

                case .workoutDownloadEnabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        workoutDownloadEnabled = value.boolValue
                    }

                case .gpsEphemerisDownloadEnabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        gpsEphemerisDownloadEnabled = value.boolValue
                    }

                case .incidentDetectionEnabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        incidentDetectionEnabled = value.boolValue
                    }

                case .groupTrackEnabled:
                    let value = localDecoder.decodeUInt8(fieldData.fieldData)
                    if value.isValidForBaseType(definition.baseType) {
                        groupTrackEnabled = value.boolValue
                    }

                }
            }
        }

        return ConnectivityMessage(bluetoothEnabled: bluetoothEnabled,
                                   bluetoothLowEnergyEnable: bluetoothLowEnergyEnable,
                                   antEnabled: antEnabled,
                                   name: name,
                                   liveTrackingEnabled: liveTrackingEnabled,
                                   weatherConditionsEnabled: weatherConditionsEnabled,
                                   weatherAlertsEnabled: weatherAlertsEnabled,
                                   autoActivityUploadEnabled: autoActivityUploadEnabled,
                                   courseDownloadEnabled: courseDownloadEnabled,
                                   workoutDownloadEnabled: workoutDownloadEnabled,
                                   gpsEphemerisDownloadEnabled: gpsEphemerisDownloadEnabled,
                                   incidentDetectionEnabled: incidentDetectionEnabled,
                                   groupTrackEnabled: groupTrackEnabled)
    }

    /// Encodes the Message into Data
    ///
    /// - Returns: Data representation
    internal override func encode() throws -> Data {
        var msgData = Data()

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .bluetoothEnabled:
                if let bluetoothEnabled = bluetoothEnabled {
                    msgData.append(bluetoothEnabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .bluetoothLowEnergyEnable:
                if let bluetoothLowEnergyEnable = bluetoothLowEnergyEnable {
                    msgData.append(bluetoothLowEnergyEnable.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .antEnabled:
                if let antEnabled = antEnabled {
                    msgData.append(antEnabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .connectivityName:
                if let name = name {
                    if let stringData = name.data(using: .utf8) {
                        msgData.append(stringData)

                        //16 typical size... but we will count the String
                        fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                    }
                }

            case .liveTrackingEnabled:
                if let liveTrackingEnabled = liveTrackingEnabled {
                    msgData.append(liveTrackingEnabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .weatherConditionsEnabled:
                if let weatherConditionsEnabled = weatherConditionsEnabled {
                    msgData.append(weatherConditionsEnabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .weatherAlertsEnabled:
                if let weatherAlertsEnabled = weatherAlertsEnabled {
                    msgData.append(weatherAlertsEnabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .autoActivityUploadEnabled:
                if let autoActivityUploadEnabled = autoActivityUploadEnabled {
                    msgData.append(autoActivityUploadEnabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .courseDownloadEnabled:
                if let courseDownloadEnabled = courseDownloadEnabled {
                    msgData.append(courseDownloadEnabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .workoutDownloadEnabled:
                if let workoutDownloadEnabled = workoutDownloadEnabled {
                    msgData.append(workoutDownloadEnabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .gpsEphemerisDownloadEnabled:
                if let gpsEphemerisDownloadEnabled = gpsEphemerisDownloadEnabled {
                    msgData.append(gpsEphemerisDownloadEnabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .incidentDetectionEnabled:
                if let incidentDetectionEnabled = incidentDetectionEnabled {
                    msgData.append(incidentDetectionEnabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            case .groupTrackEnabled:
                if let groupTrackEnabled = groupTrackEnabled {
                    msgData.append(groupTrackEnabled.uint8Value)

                    fileDefs.append(key.fieldDefinition())
                }

            }

        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: ConnectivityMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            var encodedMsg = Data()

            let defHeader = RecordHeader(localMessageType: 0, isDataMessage: false)
            encodedMsg.append(defHeader.normalHeader)
            encodedMsg.append(defMessage.encode())

            let recHeader = RecordHeader(localMessageType: 0, isDataMessage: true)
            encodedMsg.append(recHeader.normalHeader)
            encodedMsg.append(msgData)

            return encodedMsg

        } else {
            throw FitError(.encodeError(msg: "ConnectivityMessage contains no Properties Available to Encode"))
        }
    }

}
