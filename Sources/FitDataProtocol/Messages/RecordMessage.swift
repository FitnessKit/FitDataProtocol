//
//  RecordMessage.swift
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

/// FIT Record Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class RecordMessage: FitMessage {
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 20 }
    
    /// Position in Latitude
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 0,
                       unit: UnitAngle.garminSemicircle)
    private var latitude: Measurement<UnitAngle>?
    
    /// Position in Longitude
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 1,
                       unit: UnitAngle.garminSemicircle)
    private var longitude: Measurement<UnitAngle>?
    
    /// Position
    private(set) public var position: Position? {
        get {
            return Position(latitude: self.latitude, longitude: self.longitude)
        }
        set {
            self.latitude = newValue?.latitude
            self.longitude = newValue?.longitude
        }
    }
    
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0)),
                       fieldNumber: 2,
                       unit: UnitLength.meters)
    private var _altitude: Measurement<UnitLength>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 5.0, offset: 500.0)),
                       fieldNumber: 78,
                       unit: UnitLength.meters)
    private var enhancedAltitude: Measurement<UnitLength>?
    
    /// Altitude
    private(set) public var altitude: Measurement<UnitLength>? {
        get {
            return preferredField(preferred: self.enhancedAltitude, fallbakck: self._altitude)
        }
        set {
            self.enhancedAltitude = newValue
        }
    }
    
    /// Heart Rate
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 3,
                  unit: UnitCadence.beatsPerMinute)
    private(set) public var heartRate: Measurement<UnitCadence>?
    
    /// Cadence
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 4,
                  unit: UnitCadence.revolutionsPerMinute)
    private(set) public var cadence: Measurement<UnitCadence>?
    
    /// Distance
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 5,
                       unit: UnitLength.meters)
    private(set) public var distance: Measurement<UnitLength>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 6,
                       unit: UnitSpeed.metersPerSecond)
    private var _speed: Measurement<UnitSpeed>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 73,
                       unit: UnitSpeed.metersPerSecond)
    private var enhancedSpeed: Measurement<UnitSpeed>?
    
    /// Speed
    private(set) public var speed: Measurement<UnitSpeed>? {
        get {
            return preferredField(preferred: self.enhancedSpeed, fallbakck: self._speed)
        }
        set {
            self.enhancedSpeed = newValue
        }
    }
    
    /// Power
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 7,
                       unit: UnitPower.watts)
    private(set) public var power: Measurement<UnitPower>?
    
    /// Compressed Speed Distance
    ///
    /// speed 100 * m/s + 0
    /// distance 16 * m + 0
    @FitField(base: BaseTypeData(type: .byte, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 8)
    private(set) public var compressedSpeedDistance: Data?
    
    /// Grade
    @FitFieldUnit(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 9,
                  unit: UnitPercent.percent)
    private(set) public var grade: Measurement<UnitPercent>?
    
    /// Resistance
    ///
    /// Relative. 0 is none  254 is Max
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 10)
    private(set) public var resistance: UInt8?
    
    /// Time From Course
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 11,
                       unit: UnitDuration.seconds)
    private(set) public var timeFromCourse: Measurement<UnitDuration>?
    
    /// Cycle Length
    @FitFieldDimension(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 12,
                       unit: UnitLength.meters)
    private(set) public var cycleLength: Measurement<UnitLength>?
    
    /// Temperature
    @FitFieldDimension(base: BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 13,
                       unit: UnitTemperature.celsius)
    private(set) public var temperature: Measurement<UnitTemperature>?
    
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 16.0, offset: 0.0)),
              fieldNumber: 17)
    private var speedOneSecData: Data?
    
    /// Speed One Second Intervals
    public var speedOneSecondInterval: [Measurement<UnitSpeed>]? {
        return getOneSecondSpeedIntervals()
    }
    
    /// Cycles
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 18,
                  unit: UnitCount.cycles)
    private(set) public var cycles: Measurement<UnitCount>?
    
    /// Total Cycles
    @FitFieldUnit(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 19,
                  unit: UnitCount.cycles)
    private(set) public var totalCycles: Measurement<UnitCount>?
    
    
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 28,
                       unit: UnitPower.watts)
    private var compressedAccumulatedPower: Measurement<UnitPower>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 29,
                       unit: UnitPower.watts)
    private var _accumulatedPower: Measurement<UnitPower>?
    
    /// Accumulated Power
    private(set) public var accumulatedPower: Measurement<UnitPower>? {
        get {
            return preferredField(preferred: self._accumulatedPower, fallbakck: self.compressedAccumulatedPower)
        }
        set {
            self._accumulatedPower = newValue
        }
    }
    
    // Left Right Balance
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 30)
    private(set) public var leftRightBalance: LeftRightBalance?
    
    /// GPS Accuracy
    @FitFieldDimension(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 31,
                       unit: UnitLength.meters)
    private(set) public var gpsAccuracy: Measurement<UnitLength>?
    
    /// Vertical Speed
    @FitFieldDimension(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 32,
                       unit: UnitSpeed.metersPerSecond)
    private(set) public var verticalSpeed: Measurement<UnitSpeed>?
    
    /// Calories
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 33,
                       unit: UnitEnergy.kilocalories)
    private(set) public var calories: Measurement<UnitEnergy>?
    
    /// Vertical Oscillation
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                       fieldNumber: 39,
                       unit: UnitLength.millimeters)
    private(set) public var verticalOscillation: Measurement<UnitLength>?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 40,
                  unit: UnitPercent.percent)
    private var stanceTimePercent: Measurement<UnitPercent>?
    
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                       fieldNumber: 41,
                       unit: UnitDuration.millisecond)
    private var stanceTimeDuration: Measurement<UnitDuration>?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                  fieldNumber: 84,
                  unit: UnitPercent.percent)
    private var stanceTimeBalance: Measurement<UnitPercent>?
    
    /// Stance Time
    private(set) public var stanceTime: StanceTime? {
        get {
            return StanceTime(percent: self.stanceTimePercent,
                              time: self.stanceTimeDuration,
                              balance: self.stanceTimeBalance)
        }
        set {
            self.stanceTimePercent = newValue?.percent
            self.stanceTimeDuration = newValue?.time
            self.stanceTimeBalance = newValue?.balance
        }
    }
    
    /// FIT Activity Type
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 42)
    private(set) public var activity: ActivityType?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0)),
                  fieldNumber: 43,
                  unit: UnitPercent.percent)
    private var leftTorqueEffectiveness: Measurement<UnitPercent>?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0)),
                  fieldNumber: 44,
                  unit: UnitPercent.percent)
    private var rightTorqueEffectiveness: Measurement<UnitPercent>?
    
    /// Torque Effectiveness
    private(set) public var torqueEffectiveness: TorqueEffectiveness? {
        get {
            return TorqueEffectiveness(left: self.leftTorqueEffectiveness, right: self.rightTorqueEffectiveness)
        }
        set {
            self.leftTorqueEffectiveness = newValue?.left
            self.rightTorqueEffectiveness = newValue?.right
        }
    }
    
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0)),
                  fieldNumber: 45,
                  unit: UnitPercent.percent)
    private var leftPedalSmoothness: Measurement<UnitPercent>?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0)),
                  fieldNumber: 46,
                  unit: UnitPercent.percent)
    private var rightPedalSmoothness: Measurement<UnitPercent>?
    
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 2.0, offset: 0.0)),
                  fieldNumber: 47,
                  unit: UnitPercent.percent)
    private var combinedPedalSmoothness: Measurement<UnitPercent>?
    
    /// Pedal Smoothness
    private(set) public var pedalSmoothness: PedalSmoothness? {
        get {
            return PedalSmoothness(right: self.rightPedalSmoothness,
                                   left: self.leftPedalSmoothness,
                                   combined: self.combinedPedalSmoothness)
        }
        set {
            self.leftPedalSmoothness = newValue?.left
            self.rightPedalSmoothness = newValue?.right
            self.combinedPedalSmoothness = newValue?.combined
        }
    }
    
    /// Time 128 Second
    @FitFieldDimension(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0)),
                       fieldNumber: 48,
                       unit: UnitDuration.seconds)
    private(set) public var time128Second: Measurement<UnitDuration>?
    
    /// Stroke Type
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 49)
    private(set) public var stroke: Stroke?
    
    /// Zone
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 50)
    private(set) public var zone: UInt8?
    
    /// Ball Speed
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 51,
                       unit: UnitSpeed.metersPerSecond)
    private(set) public var ballSpeed: Measurement<UnitSpeed>?
    
    /// Cadence 256
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 256.0, offset: 0.0)),
                  fieldNumber: 52,
                  unit: UnitCadence.revolutionsPerMinute)
    private(set) public var cadence256: Measurement<UnitCadence>?
    
    /// Cadence 256
    @FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 128.0, offset: 0.0)),
                  fieldNumber: 53,
                  unit: UnitCadence.revolutionsPerMinute)
    private(set) public var fractionalCadence: Measurement<UnitCadence>?
    
    /// Total Hemoglobin Concentration
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 54,
                       unit: UnitConcentrationMass.gramPerDeciliter)
    private(set) public var totalHemoglobinConcentration: Measurement<UnitConcentrationMass>?
    
    /// Total Hemoglobin Concentration Minimum
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 55,
                       unit: UnitConcentrationMass.gramPerDeciliter)
    private(set) public var totalHemoglobinConcentrationMin: Measurement<UnitConcentrationMass>?
    
    /// Total Hemoglobin Concentration Maximum
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
                       fieldNumber: 56,
                       unit: UnitConcentrationMass.gramPerDeciliter)
    private(set) public var totalHemoglobinConcentrationMax: Measurement<UnitConcentrationMass>?
    
    /// Saturated Hemoglobin Percent
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                  fieldNumber: 57,
                  unit: UnitPercent.percent)
    private(set) public var saturatedHemoglobinPercent: Measurement<UnitPercent>?
    
    /// Saturated Hemoglobin Percent Minimum
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                  fieldNumber: 58,
                  unit: UnitPercent.percent)
    private(set) public var saturatedHemoglobinPercentMin: Measurement<UnitPercent>?
    
    /// Saturated Hemoglobin Percent Maximum
    @FitFieldUnit(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 10.0, offset: 0.0)),
                  fieldNumber: 59,
                  unit: UnitPercent.percent)
    private(set) public var saturatedHemoglobinPercentMax: Measurement<UnitPercent>?
    
    /// Device Index
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 62)
    private(set) public var deviceIndex: DeviceIndex?
    
    /// Grit
    ///
    /// The grit score estimates how challenging a route could be for a cyclist
    /// in terms of time spent going over sharp turns or large grade slopes
    @FitFieldUnit(base: BaseTypeData(type: .float32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 114,
                  unit: UnitFitGrit.kiloGrit)
    private(set) public var grit: Measurement<UnitFitGrit>?
    
    /// Flow
    ///
    /// The flow score estimates how long distance wise a cyclist deaccelerates over intervals
    /// where deacceleration is unnecessary such as smooth turns or small grade angle intervals
    @FitFieldUnit(base: BaseTypeData(type: .float32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 115,
                  unit: UnitFitFlow.flow)
    private(set) public var flow: Measurement<UnitFitFlow>?
    
    /// Timestamp
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 253, local: false)
    private(set) public var timeStamp: FitTime?
    
    public required init() {
        super.init()
        
        self.$timeStamp.owner = self
        
        self.$latitude.owner = self
        self.$longitude.owner = self
        self.$_altitude.owner = self
        self.$enhancedAltitude.owner = self
        self.$heartRate.owner = self
        self.$cadence.owner = self
        self.$distance.owner = self
        self.$_speed.owner = self
        self.$enhancedSpeed.owner = self
        self.$power.owner = self
        self.$compressedSpeedDistance.owner = self
        self.$grade.owner = self
        self.$resistance.owner = self
        self.$timeFromCourse.owner = self
        self.$cycleLength.owner = self
        self.$temperature.owner = self
        self.$speedOneSecData.owner = self
        self.$cycles.owner = self
        self.$totalCycles.owner = self
        self.$compressedAccumulatedPower.owner = self
        self.$_accumulatedPower.owner = self
        self.$leftRightBalance.owner = self
        self.$gpsAccuracy.owner = self
        self.$verticalSpeed.owner = self
        self.$calories.owner = self
        self.$verticalOscillation.owner = self
        self.$stanceTimePercent.owner = self
        self.$stanceTimeDuration.owner = self
        self.$stanceTimeBalance.owner = self
        self.$activity.owner = self
        self.$leftTorqueEffectiveness.owner = self
        self.$rightTorqueEffectiveness.owner = self
        self.$leftPedalSmoothness.owner = self
        self.$rightPedalSmoothness.owner = self
        self.$combinedPedalSmoothness.owner = self
        self.$time128Second.owner = self
        self.$stroke.owner = self
        self.$zone.owner = self
        self.$ballSpeed.owner = self
        self.$cadence256.owner = self
        self.$fractionalCadence.owner = self
        self.$totalHemoglobinConcentration.owner = self
        self.$totalHemoglobinConcentrationMin.owner = self
        self.$totalHemoglobinConcentrationMax.owner = self
        self.$saturatedHemoglobinPercent.owner = self
        self.$saturatedHemoglobinPercentMin.owner = self
        self.$saturatedHemoglobinPercentMax.owner = self
        self.$deviceIndex.owner = self
        self.$grit.owner = self
    }
    
    public convenience init(timeStamp: FitTime? = nil,
                            position: Position? = nil,
                            distance: Measurement<UnitLength>? = nil,
                            timeFromCourse: Measurement<UnitDuration>? = nil,
                            cycles: UInt8? = nil,
                            totalCycles: UInt32? = nil,
                            accumulatedPower: Measurement<UnitPower>? = nil,
                            altitude: Measurement<UnitLength>? = nil,
                            speed: Measurement<UnitSpeed>? = nil,
                            power: Measurement<UnitPower>? = nil,
                            gpsAccuracy: Measurement<UnitLength>? = nil,
                            verticalSpeed: Measurement<UnitSpeed>? = nil,
                            calories: Measurement<UnitEnergy>? = nil,
                            verticalOscillation: Measurement<UnitLength>? = nil,
                            stanceTime: StanceTime? = nil,
                            heartRate: UInt8? = nil,
                            cadence: UInt8? = nil,
                            grade: Measurement<UnitPercent>? = nil,
                            resistance: UInt8? = nil,
                            cycleLength: Measurement<UnitLength>? = nil,
                            temperature: Measurement<UnitTemperature>? = nil,
                            activity: ActivityType? = nil,
                            torqueEffectiveness: TorqueEffectiveness? = nil,
                            pedalSmoothness: PedalSmoothness? = nil,
                            stroke: Stroke? = nil,
                            zone: UInt8? = nil,
                            ballSpeed: Measurement<UnitSpeed>? = nil,
                            deviceIndex: DeviceIndex? = nil) {
        self.init()
        
        self.timeStamp = timeStamp
        self.position = position
        self.distance = distance
        self.timeFromCourse = timeFromCourse
        
        if let cycles = cycles {
            self.cycles = Measurement(value: Double(cycles), unit: self.$cycles.unitType)
        }
        if let totalCycles = totalCycles {
            self.totalCycles = Measurement(value: Double(totalCycles), unit: self.$totalCycles.unitType)
        }
        
        self.accumulatedPower = accumulatedPower
        self.altitude = altitude
        self.speed = speed
        self.power = power
        self.gpsAccuracy = gpsAccuracy
        self.verticalSpeed = verticalSpeed
        self.calories = calories
        self.verticalOscillation = verticalOscillation
        self.stanceTime = stanceTime
        
        if let hr = heartRate {
            self.heartRate = Measurement(value: Double(hr), unit: self.$heartRate.unitType)
        }
        
        if let cadence = cadence {
            self.cadence = Measurement(value: Double(cadence), unit: self.$cadence.unitType)
        }
        
        self.grade = grade
        self.resistance = resistance
        self.cycleLength = cycleLength
        self.temperature = temperature
        self.activity = activity
        self.torqueEffectiveness = torqueEffectiveness
        self.pedalSmoothness = pedalSmoothness
        self.stroke = stroke
        self.zone = zone
        self.ballSpeed = ballSpeed
        self.deviceIndex = deviceIndex
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
        
        let msg = RecordMessage(fieldDict: fieldDict,
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
                                           globalMessageNumber: RecordMessage.globalMessageNumber(),
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

extension RecordMessage: MessageValidator {
    
    /// Validate Message
    ///
    /// - Parameters:
    ///   - fileType: FileType the Message is being used in
    ///   - dataValidityStrategy: Data Validity Strategy
    /// - Throws: FitError
    internal func validateMessage(fileType: FileType?, dataValidityStrategy: FitFileEncoder.ValidityStrategy) throws {
        
        switch dataValidityStrategy {
        case .none:
        break // do nothing
        case .fileType:
            if fileType == FileType.activity {
                try validateActivity(isGarmin: false)
            }
        case .garminConnect:
            if fileType == FileType.activity {
                try validateActivity(isGarmin: true)
            }
        }
    }
    
    private func validateActivity(isGarmin: Bool) throws {
        
        let msg = isGarmin == true ? "GarminConnect" : "Activity Files"
        
        guard self.timeStamp != nil else {
            throw FitEncodingError.fileType("\(msg) require RecordMessage to contain timeStamp, can not be nil")
        }
        
    }
}

private extension RecordMessage {
    
    func getOneSecondSpeedIntervals() -> [Measurement<UnitSpeed>]? {
        
        let vals = self.fieldDataDict[self.$speedOneSecData.fieldNumber]?.segment(size: MemoryLayout<UInt8>.size)
        guard let values = vals else { return nil }
        
        var speed = [Measurement<UnitSpeed>?]()
        for spd in values {
            if spd.isValidForBaseType(self.$speedOneSecData.base.type) {
                
                let value = self.$speedOneSecData.base.type.decode(unit: UnitSpeed.metersPerSecond,
                                                                   data: spd,
                                                                   resolution: self.$speedOneSecData.base.resolution,
                                                                   arch: self.architecture)
                speed.append(value)
            }
            
        }
        return speed.compactMap { $0 }
        
    }
}
