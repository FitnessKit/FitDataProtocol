//
//  DeviceSettingsMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/15/19.
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

/// Device Settings Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class DeviceSettingsMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 2 }
    
    /// Active Timezone Offset
    ///
    /// Used in the Timezone array to get the offset
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 0)
    private var activeTimeZone: UInt8?
    
    /// UTC Offset
    ///
    /// Offset from system time. Required to convert timestamp from system time to UTC
    @FitField(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 1)
    private var utcOffset: UInt32?
    
    /// Offset from system time in seconds
    @FitField(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 2)
    private var timeOffset: Data?
    
    /// Time Mode
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 4)
    private(set) public var timeMode: TimeMode?
    
    /// timezone offset in 1/4 hour increments
    @FitField(base: BaseTypeData(type: .sint8, resolution: Resolution(scale: 4.0, offset: 0.0)),
              fieldNumber: 5)
    private var timeZoneOffset: Data?
    
    /// Backlight Mode
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 12)
    private(set) public var backLightMode: BacklightMode?
    
    /// Activity Tracker Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 36)
    private(set) public var activityTrackerEnabled: Bool?
    
    /// Clock Time
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 39, local: false)
    private(set) public var clockTime: FitTime?
    
    /// Pages Enabled
    ///
    /// enabled screens for each supported loop
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 40)
    private(set) public var pagesEnabled: Enabled?
    
    /// Move Alert Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 46)
    private(set) public var moveAlertEnabled: Bool?
    
    /// Date Mode
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 47)
    private(set) public var dateMode: DateMode?
    
    /// Display Orientation
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 55)
    private(set) public var displayOrientation: DisplayOrientation?
    
    /// Mounting Side
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 56)
    private(set) public var mountingSide: Side?
    
    /// Default Page
    ///
    /// indicate one page as default for each supported loop
    @FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 57)
    private(set) public var defaultPage: Enabled?
    
    /// Autosync Minimum Steps
    ///
    /// Minimum steps before an autosync can occur
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 58, unit: UnitCount.steps)
    private(set) public var autosyncMinimumSteps: Measurement<UnitCount>?
    
    /// Autosync Minimum Time
    ///
    /// Minimum minutes before an autosync can occur
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 59, unit: UnitDuration.minutes)
    private(set) public var autosyncMinimumTime: Measurement<UnitDuration>?
    
    /// Lactate Threshold Autodetect Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 80)
    private(set) public var lactateThresholdAutodetectEnabled: Bool?
    
    /// BLE Auto upload Enabled
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 80)
    private(set) public var bleAutoUploadEnabled: Bool?
    
    /// Auto Sync Frequency
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 89)
    private(set) public var autoSyncFrequency: AutoSyncFrequency?
    
    /// Auto Activity Detect
    ///
    /// Allows setting specific activities auto-activity detect enabled/disabled settings
    @FitField(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 90)
    private(set) public var autoActivityDetect: AutoActivityDetect?
    
    /// Number of screens configured to display
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 94)
    private(set) public var numberOfScreens: UInt8?
    
    /// Smart Notification Display Orientation
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 95)
    private(set) public var smartNotificationDisplayOrientation: DisplayOrientation?
    
    /// Tap Interace
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 134)
    private(set) public var tapInterface: Switch?
    
    public required init() {
        super.init()
        
        self.$activeTimeZone.owner = self
        self.$utcOffset.owner = self
        self.$timeMode.owner = self
        self.$timeZoneOffset.owner = self
        self.$backLightMode.owner = self
        self.$activityTrackerEnabled.owner = self
        self.$clockTime.owner = self
        self.$pagesEnabled.owner = self
        self.$dateMode.owner = self
        self.$displayOrientation.owner = self
        self.$mountingSide.owner = self
        self.$defaultPage.owner = self
        self.$autosyncMinimumSteps.owner = self
        self.$autosyncMinimumTime.owner = self
        self.$lactateThresholdAutodetectEnabled.owner = self
        self.$bleAutoUploadEnabled.owner = self
        self.$autoSyncFrequency.owner = self
        self.$autoActivityDetect.owner = self
        self.$numberOfScreens.owner = self
        self.$smartNotificationDisplayOrientation.owner = self
        self.$tapInterface.owner = self
    }
    
    public convenience init(timeMode: TimeMode? = nil,
                            backLightMode: BacklightMode? = nil,
                            activityTrackerEnabled: Bool? = nil,
                            clockTime: FitTime? = nil,
                            pagesEnabled: Enabled? = nil,
                            moveAlertEnabled: Bool? = nil,
                            dateMode: DateMode? = nil,
                            displayOrientation: DisplayOrientation? = nil,
                            mountingSide: Side? = nil,
                            defaultPage: Enabled? = nil,
                            autosyncMinimumSteps: UInt16? = nil,
                            autosyncMinimumTime: Measurement<UnitDuration>? = nil,
                            lactateThresholdAutodetectEnabled: Bool? = nil,
                            bleAutoUploadEnabled: Bool? = nil,
                            autoSyncFrequency: AutoSyncFrequency? = nil,
                            autoActivityDetect: AutoActivityDetect? = nil,
                            numberOfScreens: UInt8? = nil,
                            smartNotificationDisplayOrientation: DisplayOrientation? = nil,
                            tapInterface: Switch? = nil) {
        self.init()
        
        self.timeMode = timeMode
        self.backLightMode = backLightMode
        self.activityTrackerEnabled = activityTrackerEnabled
        self.clockTime = clockTime
        self.pagesEnabled = pagesEnabled
        self.moveAlertEnabled = moveAlertEnabled
        self.dateMode = dateMode
        self.displayOrientation = displayOrientation
        self.mountingSide = mountingSide
        self.defaultPage = defaultPage
        
        if let autosyncMinSteps = autosyncMinimumSteps {
            self.autosyncMinimumSteps = Measurement(value: Double(autosyncMinSteps), unit: UnitCount.steps)
        }
        
        self.autosyncMinimumTime = autosyncMinimumTime
        self.lactateThresholdAutodetectEnabled = lactateThresholdAutodetectEnabled
        self.bleAutoUploadEnabled = bleAutoUploadEnabled
        self.autoSyncFrequency = autoSyncFrequency
        self.autoActivityDetect = autoActivityDetect
        self.numberOfScreens = numberOfScreens
        self.smartNotificationDisplayOrientation = smartNotificationDisplayOrientation
        self.tapInterface = tapInterface
    }
    
    /// Decode Message Data into FitMessage
    ///
    /// - Parameters:
    ///   - fieldData: FileData
    ///   - definition: Definition Message
    /// - Returns: FitMessage Result
    override func decode<F>(fieldData: FieldData, definition: DefinitionMessage) -> Result<F, FitDecodingError> where F: FitMessage {
        var testDecoder = DecodeData()
        
        var fieldDict: [UInt8: FieldDefinition] = [UInt8: FieldDefinition]()
        var fieldDataDict: [UInt8: Data] = [UInt8: Data]()
        
        for definition in definition.fieldDefinitions {
            let fieldData = testDecoder.decodeData(fieldData.fieldData, length: Int(definition.size))
            
            fieldDict[definition.fieldDefinitionNumber] = definition
            fieldDataDict[definition.fieldDefinitionNumber] = fieldData
        }
        
        let msg = DeviceSettingsMessage(fieldDict: fieldDict,
                                        fieldDataDict: fieldDataDict,
                                        architecture: definition.architecture)
        
        let devData = self.decodeDeveloperData(data: fieldData, definition: definition)
        msg.developerData = devData.isEmpty ? nil : devData
        
        return .success(msg as! F)
    }
    
    /// Encodes the Definition Message for FitMessage
    ///
    /// - Parameters:
    ///   - fileType: FileType
    ///   - dataValidityStrategy: Validity Strategy
    /// - Returns: DefinitionMessage Result
    internal override func encodeDefinitionMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) -> Result<DefinitionMessage, FitEncodingError> {
        
        let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
        
        guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        let defMessage = DefinitionMessage(architecture: .little,
                                           globalMessageNumber: CadenceZoneMessage.globalMessageNumber(),
                                           fields: UInt8(fields.count),
                                           fieldDefinitions: fields,
                                           developerFieldDefinitions: [DeveloperFieldDefinition]())
        
        return.success(defMessage)
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
        
        return self.encodeMessageFields(localMessageType: localMessageType)
    }
}

public extension DeviceSettingsMessage {
    
    /// Enabled
    struct Enabled: OptionSet {
        public let rawValue: UInt16
        public init(rawValue: UInt16) { self.rawValue = rawValue }
        
        /// One
        public static let one       = Enabled(rawValue: 1 << 0)
        /// Two
        public static let two       = Enabled(rawValue: 1 << 1)
        /// Three
        public static let three     = Enabled(rawValue: 1 << 2)
        /// Four
        public static let four      = Enabled(rawValue: 1 << 3)
        /// Five
        public static let five      = Enabled(rawValue: 1 << 4)
        /// Six
        public static let six       = Enabled(rawValue: 1 << 5)
        /// Seven
        public static let seven     = Enabled(rawValue: 1 << 6)
        /// Eight
        public static let eight     = Enabled(rawValue: 1 << 7)
        /// Nine
        public static let nine      = Enabled(rawValue: 1 << 8)
        /// Ten
        public static let ten       = Enabled(rawValue: 1 << 9)
        /// Eleven
        public static let eleven    = Enabled(rawValue: 1 << 10)
        /// Twelve
        public static let twelve    = Enabled(rawValue: 1 << 11)
        /// Thirteen
        public static let thirteen  = Enabled(rawValue: 1 << 12)
        /// Fourteen
        public static let fourteen  = Enabled(rawValue: 1 << 13)
        /// Fifteen
        public static let fifteen   = Enabled(rawValue: 1 << 14)
        /// Sixteen
        public static let sixteen   = Enabled(rawValue: 1 << 15)
    }
    
}

// MARK: - FitFieldCodeable
extension DeviceSettingsMessage.Enabled: FitFieldCodeable {
    
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
            return DeviceSettingsMessage.Enabled(rawValue: value) as? T
        }
        
        return nil
    }
}
