//
//  SegmentLapMessage.swift
//  
//
//  Created by Antony Gardiner on 14/03/23.
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
import AntMessageProtocol
import FitnessUnits

/// FIT Segment Lap Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class SegmentLapMessage: FitMessage {
	
	/// FIT Message Global Number
	public override class func globalMessageNumber() -> UInt16 { return 142 }
	
	/// Start Time
	@FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
				  fieldNumber: 2, local: false)
	private(set) public var startTime: FitTime?
	
	/// Position in Latitude
	@FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 3,
					   unit: UnitAngle.garminSemicircle)
	private var startLatitude: Measurement<UnitAngle>?
	
	/// Position in Longitude
	@FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 4,
					   unit: UnitAngle.garminSemicircle)
	private var startLongitude: Measurement<UnitAngle>?
	
	/// Start Position
	private(set) public var startPosition: Position? {
		get {
			return Position(latitude: self.startLatitude, longitude: self.startLongitude)
		}
		set {
			self.startLatitude = newValue?.latitude
			self.startLongitude = newValue?.longitude
		}
	}
	
	/// Position in Latitude
	@FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 5,
					   unit: UnitAngle.garminSemicircle)
	private var endLatitude: Measurement<UnitAngle>?
	
	/// Position in Longitude
	@FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 6,
					   unit: UnitAngle.garminSemicircle)
	private var endLongitude: Measurement<UnitAngle>?
	
	/// End Position
	private(set) public var endPosition: Position? {
		get {
			return Position(latitude: self.endLatitude, longitude: self.endLongitude)
		}
		set {
			self.endLatitude = newValue?.latitude
			self.endLongitude = newValue?.longitude
		}
	}
	
	/// Total Elapsed Time
	///
	/// Includes pauses
	@FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
					   fieldNumber: 7,
					   unit: UnitDuration.seconds)
	private(set) public var totalElapsedTime: Measurement<UnitDuration>?
	
	/// Total Timer Time
	///
	/// Excludes pauses
	@FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
					   fieldNumber: 8,
					   unit: UnitDuration.seconds)
	private(set) public var totalTimerTime: Measurement<UnitDuration>?
	
	/// Total Distance
	@FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 100.0, offset: 0.0)),
					   fieldNumber: 9,
					   unit: UnitLength.meters)
	private(set) public var totalDistance: Measurement<UnitLength>?
	
	/// Total Cycles
	@FitFieldUnit(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
				  fieldNumber: 10,
				  unit: UnitCount.cycles)
	private(set) public var totalCycles: Measurement<UnitCount>?
	
	/// Name of segment
	@FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 29)
	private(set) public var name: String?
	
	/// Total Work
	@FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 33,
					   unit: UnitEnergy.joules)
	private(set) public var totalWork: Measurement<UnitEnergy>?
	
	/// Total Moving Time
	@FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
					   fieldNumber: 44,
					   unit: UnitDuration.seconds)
	private(set) public var totalMovingTime: Measurement<UnitDuration>?
	
	/// Active Time
	@FitFieldDimension(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1000.0, offset: 0.0)),
					   fieldNumber: 56,
					   unit: UnitDuration.seconds)
	private(set) public var activeTime: Measurement<UnitDuration>?
	
	/// Message Index
	@FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 254)
	private(set) public var messageIndex: MessageIndex?
	
	/// Total Calories
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 11,
					   unit: UnitEnergy.kilocalories)
	private(set) public var totalCalories: Measurement<UnitEnergy>?
	
	/// Total Fat Calories
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 12,
					   unit: UnitEnergy.kilocalories)
	private(set) public var totalFatCalories: Measurement<UnitEnergy>?
	
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
					   fieldNumber: 13,
					   unit: UnitSpeed.metersPerSecond)
	private(set) public var averageSpeed: Measurement<UnitSpeed>?
	
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
					   fieldNumber: 14,
					   unit: UnitSpeed.metersPerSecond)
	private(set) public var maximumSpeed: Measurement<UnitSpeed>?
	
	/// Average Power
	///
	/// If nil you can use totalPower / totalTimerTime
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 19,
					   unit: UnitPower.watts)
	private(set) public var averagePower: Measurement<UnitPower>?
	
	/// Maximum Power
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 20,
					   unit: UnitPower.watts)
	private(set) public var maximumPower: Measurement<UnitPower>?
	
	/// Total Ascent
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 21,
					   unit: UnitLength.meters)
	private(set) public var totalAscent: Measurement<UnitLength>?
	
	/// Total Descent
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 22,
					   unit: UnitLength.meters)
	private(set) public var totalDescent: Measurement<UnitLength>?
	
	/// Normalized Power
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 30,
					   unit: UnitPower.watts)
	private(set) public var normalizedPower: Measurement<UnitPower>?
	
	/// Left Right Balance scaled by 100
	@FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 31)
	private(set) public var leftRightBalance: LeftRightBalance100?
	
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0)),
					   fieldNumber: 34,
					   unit: UnitLength.meters)
	private(set) public var averageAltitude: Measurement<UnitLength>?
	
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0)),
					   fieldNumber: 35,
					   unit: UnitLength.meters)
	private(set) public var maximumAltitude: Measurement<UnitLength>?
	
	/// Average Grade
	@FitFieldUnit(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
				  fieldNumber: 37,
				  unit: UnitPercent.percent)
	private(set) public var averageGrade: Measurement<UnitPercent>?
	
	/// Average Positive Grade
	@FitFieldUnit(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
				  fieldNumber: 38,
				  unit: UnitPercent.percent)
	private(set) public var averagePositiveGrade: Measurement<UnitPercent>?
	
	/// Average Negitive Grade
	@FitFieldUnit(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
				  fieldNumber: 39,
				  unit: UnitPercent.percent)
	private(set) public var averageNegitiveGrade: Measurement<UnitPercent>?
	
	/// Maximum Positive Grade
	@FitFieldUnit(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
				  fieldNumber: 40,
				  unit: UnitPercent.percent)
	private(set) public var maximumPositiveGrade: Measurement<UnitPercent>?
	
	/// Maximum Negitive Grade
	@FitFieldUnit(base: BaseTypeData(type: .sint16, resolution: Resolution(scale: 100.0, offset: 0.0)),
				  fieldNumber: 41,
				  unit: UnitPercent.percent)
	private(set) public var maximumNegitiveGrade: Measurement<UnitPercent>?

	/// Repetion Number
	@FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 53)
	private(set) public var repetionNumber: UInt16?
	
	@FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 5.0, offset: 500.0)),
					   fieldNumber: 54,
					   unit: UnitLength.meters)
	private(set) public var minimumAltitude: Measurement<UnitLength>?
	
	/// Workout Step Index
	@FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 57)
	private(set) public var workoutStepIndex: MessageIndex?
	
	/// Front gear shift count
	@FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 69)
	private(set) public var frontGearShiftCount: UInt16?
	
	/// Rear gear shift count
	@FitField(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 70)
	private(set) public var rearGearShiftCount: UInt16?
	
	/// Event
	@FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 0)
	private(set) public var event: Event?
	
	/// Event Type
	@FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 1)
	private(set) public var eventType: EventType?
	
	/// Average Heart Rate
	@FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
				  fieldNumber: 15,
				  unit: UnitCadence.beatsPerMinute)
	private(set) public var averageHeartRate: Measurement<UnitCadence>?
	
	/// Maximum Heart Rate
	@FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
				  fieldNumber: 16,
				  unit: UnitCadence.beatsPerMinute)
	private(set) public var maximumHeartRate: Measurement<UnitCadence>?
	
	/// Average Cadence
	///
	/// If nil you can use totalCycles / totalTimerTime
	@FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
				  fieldNumber: 17,
				  unit: UnitCadence.revolutionsPerMinute)
	private(set) public var averageCadence: Measurement<UnitCadence>?
	
	/// Maximum Cadence
	@FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
				  fieldNumber: 18,
				  unit: UnitCadence.revolutionsPerMinute)
	private(set) public var maximumCadence: Measurement<UnitCadence>?
	
	/// Sport
	@FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 23)
	private(set) public var sport: Sport?
	
	/// Event Group
	@FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 24)
	private(set) public var eventGroup: UInt8?
	
	/// Sub Sport
	@FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 32)
	private(set) public var subSport: SubSport?
	
	/// GPS Accuracy
	@FitFieldDimension(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 36,
					   unit: UnitLength.meters)
	private(set) public var gpsAccuracy: Measurement<UnitLength>?
	
	/// Average Temperature
	@FitFieldDimension(base: BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 42,
					   unit: UnitTemperature.celsius)
	private(set) public var averageTemperature: Measurement<UnitTemperature>?
	
	/// Maximum Temperature
	@FitFieldDimension(base: BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
					   fieldNumber: 43,
					   unit: UnitTemperature.celsius)
	private(set) public var maximumTemperature: Measurement<UnitTemperature>?
	
	/// Minimum Heart Rate
	@FitFieldUnit(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
				  fieldNumber: 55,
				  unit: UnitCadence.beatsPerMinute)
	private(set) public var minimumHeartRate: Measurement<UnitCadence>?
	
	// Sport Event?
	
	// UUID?
	@FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
			  fieldNumber: 65)
	private(set) public var uuid: String?
	
	/// Segment Lap end time
	@FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
				  fieldNumber: 253, local: false)
	private(set) public var timeStamp: FitTime?
	
	public required init() {
		super.init()

		self.$messageIndex.owner = self
		self.$timeStamp.owner = self
		self.$startTime.owner = self
		self.$startLatitude.owner = self
		self.$startLongitude.owner = self
		self.$endLatitude.owner = self
		self.$endLongitude.owner = self
		self.$totalElapsedTime.owner = self
		self.$totalTimerTime.owner = self
		self.$totalDistance.owner = self
		self.$totalCycles.owner = self
		self.$name.owner = self
		self.$totalWork.owner = self
		self.$totalMovingTime.owner = self
		self.$activeTime.owner = self
		self.$messageIndex.owner = self
		self.$totalCalories.owner = self
		self.$totalFatCalories.owner = self
		self.$averageSpeed.owner = self
		self.$maximumSpeed.owner = self
		self.$averagePower.owner = self
		self.$maximumPower.owner = self
		self.$totalAscent.owner = self
		self.$totalDescent.owner = self
		self.$normalizedPower.owner = self
		self.$leftRightBalance.owner = self
		self.$averageAltitude.owner = self
		self.$maximumAltitude.owner = self
		self.$averageGrade.owner = self
		self.$averagePositiveGrade.owner = self
		self.$averageNegitiveGrade.owner = self
		self.$maximumPositiveGrade.owner = self
		self.$maximumNegitiveGrade.owner = self
		self.$repetionNumber.owner = self
		self.$minimumAltitude.owner = self
		self.$workoutStepIndex.owner = self
		self.$frontGearShiftCount.owner = self
		self.$rearGearShiftCount.owner = self
		self.$event.owner = self
		self.$eventType.owner = self
		self.$averageHeartRate.owner = self
		self.$maximumHeartRate.owner = self
		self.$averageCadence.owner = self
		self.$maximumCadence.owner = self
		self.$sport.owner = self
		self.$eventGroup.owner = self
		self.$subSport.owner = self
		self.$gpsAccuracy.owner = self
		self.$averageTemperature.owner = self
		self.$maximumTemperature.owner = self
		self.$minimumHeartRate.owner = self
		self.$uuid.owner = self
	}
	
	public convenience init(startTime: FitTime? = nil,
							startLatitude: Measurement<UnitAngle>? = nil,
							startLongitude: Measurement<UnitAngle>? = nil,
							endLatitude: Measurement<UnitAngle>? = nil,
							endLongitude: Measurement<UnitAngle>? = nil,
							totalElapsedTime: Measurement<UnitDuration>? = nil,
							totalTimerTime: Measurement<UnitDuration>? = nil,
							totalDistance: Measurement<UnitLength>? = nil,
							totalCycles: Measurement<UnitCount>? = nil,
							name: String? = nil,
							totalWork: Measurement<UnitEnergy>? = nil,
							totalMovingTime: Measurement<UnitDuration>? = nil,
							activeTime: Measurement<UnitDuration>? = nil,
							messageIndex: MessageIndex? = nil,
							totalCalories: Measurement<UnitEnergy>? = nil,
							totalFatCalories: Measurement<UnitEnergy>? = nil,
							averageSpeed: Measurement<UnitSpeed>? = nil,
							maximumSpeed: Measurement<UnitSpeed>? = nil,
							averagePower: Measurement<UnitPower>? = nil,
							maximumPower: Measurement<UnitPower>? = nil,
							totalAscent: Measurement<UnitLength>? = nil,
							totalDescent: Measurement<UnitLength>? = nil,
							normalizedPower: Measurement<UnitPower>? = nil,
							leftRightBalance: LeftRightBalance100? = nil,
							averageAltitude: Measurement<UnitLength>? = nil,
							maximumAltitude: Measurement<UnitLength>? = nil,
							averageGrade: Measurement<UnitPercent>? = nil,
							averagePositiveGrade: Measurement<UnitPercent>? = nil,
							averageNegitiveGrade: Measurement<UnitPercent>? = nil,
							maximumPositiveGrade: Measurement<UnitPercent>? = nil,
							maximumNegitiveGrade: Measurement<UnitPercent>? = nil,
							repetionNumber: UInt16? = nil,
							minimumAltitude: Measurement<UnitLength>? = nil,
							workoutStepIndex: MessageIndex? = nil,
							frontGearShiftCount: UInt16? = nil,
							rearGearShiftCount: UInt16? = nil,
							event: Event? = nil,
							eventType: EventType? = nil,
							averageHeartRate: Measurement<UnitCadence>? = nil,
							maximumHeartRate: Measurement<UnitCadence>? = nil,
							averageCadence: Measurement<UnitCadence>? = nil,
							maximumCadence: Measurement<UnitCadence>? = nil,
							sport: Sport? = nil,
							eventGroup: UInt8? = nil,
							subSport: SubSport? = nil,
							gpsAccuracy: Measurement<UnitLength>? = nil,
							averageTemperature: Measurement<UnitTemperature>? = nil,
							maximumTemperature: Measurement<UnitTemperature>? = nil,
							minimumHeartRate: Measurement<UnitCadence>? = nil,
							uuid: String? = nil,
							timeStamp: FitTime? = nil) {
		self.init()

		self.startTime = startTime
		self.startLatitude = startLatitude
		self.startLongitude = startLongitude
		self.endLatitude = endLatitude
		self.endLongitude = endLongitude
		self.totalElapsedTime = totalElapsedTime
		self.totalTimerTime = totalTimerTime
		self.totalDistance = totalDistance
		self.totalCycles = totalCycles
		self.name = name
		self.totalWork = totalWork
		self.totalMovingTime = totalMovingTime
		self.activeTime = activeTime
		self.messageIndex = messageIndex
		self.totalCalories = totalCalories
		self.totalFatCalories = totalFatCalories
		self.averageSpeed = averageSpeed
		self.maximumSpeed = maximumSpeed
		self.averagePower = averagePower
		self.maximumPower = maximumPower
		self.totalAscent = totalAscent
		self.totalDescent = totalDescent
		self.normalizedPower = normalizedPower
		self.leftRightBalance = leftRightBalance
		self.averageAltitude = averageAltitude
		self.maximumAltitude = maximumAltitude
		self.averageGrade = averageGrade
		self.averagePositiveGrade = averagePositiveGrade
		self.averageNegitiveGrade = averageNegitiveGrade
		self.maximumPositiveGrade = maximumPositiveGrade
		self.maximumNegitiveGrade = maximumNegitiveGrade
		self.repetionNumber = repetionNumber
		self.minimumAltitude = minimumAltitude
		self.workoutStepIndex = workoutStepIndex
		self.frontGearShiftCount = frontGearShiftCount
		self.rearGearShiftCount = rearGearShiftCount
		self.event = event
		self.eventType = eventType
		self.averageHeartRate = averageHeartRate
		self.maximumHeartRate = maximumHeartRate
		self.averageCadence = averageCadence
		self.maximumCadence = maximumCadence
		self.sport = sport
		self.eventGroup = eventGroup
		self.subSport = subSport
		self.gpsAccuracy = gpsAccuracy
		self.averageTemperature = averageTemperature
		self.maximumTemperature = maximumTemperature
		self.minimumHeartRate = minimumHeartRate
		self.uuid = uuid
		self.timeStamp = timeStamp
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
		
		let msg = SegmentLapMessage(fieldDict: fieldDict,
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
		
		do {
			try validateMessage(fileType: fileType, dataValidityStrategy: dataValidityStrategy)
		} catch let error as FitEncodingError {
			return.failure(error)
		} catch {
			return.failure(FitEncodingError.fileType(error.localizedDescription))
		}
		
		let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
		
		guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
		
		let defMessage = DefinitionMessage(architecture: .little,
										   globalMessageNumber: LapMessage.globalMessageNumber(),
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

extension SegmentLapMessage: MessageValidator {
	
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
			throw FitEncodingError.fileType("\(msg) require SegmentLapMessage to contain timeStamp, can not be nil")
		}
		
		guard self.event != nil else {
			throw FitEncodingError.fileType("\(msg) require SegmentLapMessage to contain event, can not be nil")
		}
		
		guard self.eventType != nil else {
			throw FitEncodingError.fileType("\(msg) require SegmentLapMessage to contain eventType, can not be nil")
		}
	}
}
