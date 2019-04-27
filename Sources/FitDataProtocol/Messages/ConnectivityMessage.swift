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
    public override class func globalMessageNumber() -> UInt16 { return 127 }

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

    public init(bluetoothEnabled: Bool? = nil,
                bluetoothLowEnergyEnable: Bool? = nil,
                antEnabled: Bool? = nil,
                name: String? = nil,
                liveTrackingEnabled: Bool? = nil,
                weatherConditionsEnabled: Bool? = nil,
                weatherAlertsEnabled: Bool? = nil,
                autoActivityUploadEnabled: Bool? = nil,
                courseDownloadEnabled: Bool? = nil,
                workoutDownloadEnabled: Bool? = nil,
                gpsEphemerisDownloadEnabled: Bool? = nil,
                incidentDetectionEnabled: Bool? = nil,
                groupTrackEnabled: Bool? = nil) {

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

    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    ///   - dataStrategy: Decoding Strategy
    /// - Returns: FitMessage
    /// - Throws: FitDecodingError
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

            let fitKey = FitCodingKeys(intValue: Int(definition.fieldDefinitionNumber))

            switch fitKey {
            case .none:
                // We still need to pull this data off the stack
                let _ = localDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
                //print("ConnectivityMessage Unknown Field Number: \(definition.fieldDefinitionNumber)")

            case .some(let key):
                switch key {

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

    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage Result
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) ->  Result<DefinitionMessage, FitEncodingError> {

//        do {
//            try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)
//        } catch let error as FitEncodingError {
//            return.failure(error)
//        } catch {
//            return.failure(FitEncodingError.fileType(error.localizedDescription))
//        }

        var fileDefs = [FieldDefinition]()

        for key in FitCodingKeys.allCases {

            switch key {
            case .bluetoothEnabled:
                if let _ = bluetoothEnabled { fileDefs.append(key.fieldDefinition()) }
            case .bluetoothLowEnergyEnable:
                if let _ = bluetoothLowEnergyEnable { fileDefs.append(key.fieldDefinition()) }
            case .antEnabled:
                if let _ = antEnabled { fileDefs.append(key.fieldDefinition()) }
            case .connectivityName:
                if let stringData = name?.data(using: .utf8) {
                    //16 typical size... but we will count the String

                    guard stringData.count <= UInt8.max else {
                        return.failure(FitEncodingError.properySize("name size can not exceed 255"))
                    }

                    fileDefs.append(key.fieldDefinition(size: UInt8(stringData.count)))
                }
            case .liveTrackingEnabled:
                if let _ = liveTrackingEnabled { fileDefs.append(key.fieldDefinition()) }
            case .weatherConditionsEnabled:
                if let _ = weatherConditionsEnabled { fileDefs.append(key.fieldDefinition()) }
            case .weatherAlertsEnabled:
                if let _ = weatherAlertsEnabled { fileDefs.append(key.fieldDefinition()) }
            case .autoActivityUploadEnabled:
                if let _ = autoActivityUploadEnabled { fileDefs.append(key.fieldDefinition()) }
            case .courseDownloadEnabled:
                if let _ = courseDownloadEnabled { fileDefs.append(key.fieldDefinition()) }
            case .workoutDownloadEnabled:
                if let _ = workoutDownloadEnabled { fileDefs.append(key.fieldDefinition()) }
            case .gpsEphemerisDownloadEnabled:
                if let _ = gpsEphemerisDownloadEnabled { fileDefs.append(key.fieldDefinition()) }
            case .incidentDetectionEnabled:
                if let _ = incidentDetectionEnabled { fileDefs.append(key.fieldDefinition()) }
            case .groupTrackEnabled:
                if let _ = groupTrackEnabled { fileDefs.append(key.fieldDefinition())}
            }
        }

        if fileDefs.count > 0 {

            let defMessage = DefinitionMessage(architecture: .little,
                                               globalMessageNumber: ConnectivityMessage.globalMessageNumber(),
                                               fields: UInt8(fileDefs.count),
                                               fieldDefinitions: fileDefs,
                                               developerFieldDefinitions: [DeveloperFieldDefinition]())

            return.success(defMessage)
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
    }

    /// Encodes the Message into Data
    ///
    /// - Parameters:
    ///   - localMessageType: Message Number, that matches the defintions header number
    ///   - definition: DefinitionMessage
    /// - Returns: Data Result
    internal override func encode(localMessageType: UInt8, definition: DefinitionMessage) -> Result<Data, FitEncodingError> {

        guard definition.globalMessageNumber == type(of: self).globalMessageNumber() else  {
            return.failure(self.encodeWrongDefinitionMessage())
        }

        let msgData = MessageData()

        for key in FitCodingKeys.allCases {

            switch key {
            case .bluetoothEnabled:
                if let bluetoothEnabled = bluetoothEnabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: bluetoothEnabled)) {
                        return.failure(error)
                    }
                }

            case .bluetoothLowEnergyEnable:
                if let bluetoothLowEnergyEnable = bluetoothLowEnergyEnable {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: bluetoothLowEnergyEnable)) {
                        return.failure(error)
                    }
                }

            case .antEnabled:
                if let antEnabled = antEnabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: antEnabled)) {
                        return.failure(error)
                    }
                }

            case .connectivityName:
                if let name = name {
                    if let stringData = name.data(using: .utf8) {
                        msgData.append(stringData)
                    }
                }

            case .liveTrackingEnabled:
                if let liveTrackingEnabled = liveTrackingEnabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: liveTrackingEnabled)) {
                        return.failure(error)
                    }
                }

            case .weatherConditionsEnabled:
                if let weatherConditionsEnabled = weatherConditionsEnabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: weatherConditionsEnabled)) {
                        return.failure(error)
                    }
                }

            case .weatherAlertsEnabled:
                if let weatherAlertsEnabled = weatherAlertsEnabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: weatherAlertsEnabled)) {
                        return.failure(error)
                    }
                }

            case .autoActivityUploadEnabled:
                if let autoActivityUploadEnabled = autoActivityUploadEnabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: autoActivityUploadEnabled)) {
                        return.failure(error)
                    }
                }

            case .courseDownloadEnabled:
                if let courseDownloadEnabled = courseDownloadEnabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: courseDownloadEnabled)) {
                        return.failure(error)
                    }
                }

            case .workoutDownloadEnabled:
                if let workoutDownloadEnabled = workoutDownloadEnabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: workoutDownloadEnabled)) {
                        return.failure(error)
                    }
                }

            case .gpsEphemerisDownloadEnabled:
                if let gpsEphemerisDownloadEnabled = gpsEphemerisDownloadEnabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: gpsEphemerisDownloadEnabled)) {
                        return.failure(error)
                    }
                }

            case .incidentDetectionEnabled:
                if let incidentDetectionEnabled = incidentDetectionEnabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: incidentDetectionEnabled)) {
                        return.failure(error)
                    }
                }

            case .groupTrackEnabled:
                if let groupTrackEnabled = groupTrackEnabled {
                    if let error = msgData.shouldAppend(key.encodeKeyed(value: groupTrackEnabled)) {
                        return.failure(error)
                    }
                }
            }
        }

        if msgData.message.count > 0 {
            return.success(encodedDataMessage(localMessageType: localMessageType, msgData: msgData.message))
        } else {
            return.failure(self.encodeNoPropertiesAvailable())
        }
    }
}
