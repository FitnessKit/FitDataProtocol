//
//  WeatherConditionsMessage.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 12/24/19.
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

/// FIT Weather Conditions Message
@available(swift 4.2)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
open class WeatherConditionsMessage: FitMessage {
    let precipitationRange = ClosedRange(uncheckedBounds: (lower: 0, upper: 100))
    
    /// FIT Message Global Number
    public override class func globalMessageNumber() -> UInt16 { return 128 }
    
    /// Weather Report
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 0)
    private(set) public var report: WeatherReport?
    
    /// Temperature
    @FitFieldDimension(base: BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 1,
                       unit: UnitTemperature.celsius)
    private(set) public var temperature: Measurement<UnitTemperature>?
    
    /// Condition
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 2)
    private(set) public var condition: WeatherStatus?
    
    /// Wind Direction
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 3,
                       unit: UnitAngle.degrees)
    private(set) public var windDirection: Measurement<UnitAngle>?
    
    /// Wind Speed
    @FitFieldDimension(base: BaseTypeData(type: .uint16, resolution: Resolution(scale: 1000.0, offset: 0.0)),
                       fieldNumber: 4,
                       unit: UnitSpeed.metersPerSecond)
    private(set) public var windSpeed: Measurement<UnitSpeed>?
    
    /// Precipitation Probability
    ///
    /// - note: 0 - 100
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 5)
    private(set) public var precipitationProbability: UInt8?
    
    /// Feels Like Temperature
    ///
    /// Heat Index if GCS heat index above or equal to 90F or wind chill if GCS windChill below or equal to 32F
    @FitFieldDimension(base: BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 6,
                       unit: UnitTemperature.celsius)
    private(set) public var feelsLikeTemperature: Measurement<UnitTemperature>?
    
    /// Relative Humidity
    @FitField(base: BaseTypeData(type: .uint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 7)
    private(set) public var relativeHumidity: UInt8?
    
    /// Location
    @FitField(base: BaseTypeData(type: .string, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 8)
    private(set) public var location: String?
    
    /// Observed Time
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 9, local: false)
    private(set) public var observedTime: FitTime?
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 10,
                       unit: UnitAngle.garminSemicircle)
    private var latitude: Measurement<UnitAngle>?
    
    @FitFieldDimension(base: BaseTypeData(type: .sint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 11,
                       unit: UnitAngle.garminSemicircle)
    private var longitude: Measurement<UnitAngle>?
    
    /// Observed Location
    private(set) public var observedLocation: Position? {
        get {
            return Position(latitude: self.latitude, longitude: self.longitude)
        }
        set {
            self.latitude = newValue?.latitude
            self.longitude = newValue?.longitude
        }
    }
    
    /// Day of Week
    @FitField(base: BaseTypeData(type: .enumtype, resolution: Resolution(scale: 1.0, offset: 0.0)),
              fieldNumber: 12)
    private(set) public var dayOfWeek: DayOfWeek?
    
    /// High Temperature
    @FitFieldDimension(base: BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 13,
                       unit: UnitTemperature.celsius)
    private(set) public var highTemperature: Measurement<UnitTemperature>?
    
    /// Low Temperature
    @FitFieldDimension(base: BaseTypeData(type: .sint8, resolution: Resolution(scale: 1.0, offset: 0.0)),
                       fieldNumber: 14,
                       unit: UnitTemperature.celsius)
    private(set) public var lowTemperature: Measurement<UnitTemperature>?
    
    /// Timestamp
    @FitFieldTime(base: BaseTypeData(type: .uint32, resolution: Resolution(scale: 1.0, offset: 0.0)),
                  fieldNumber: 253, local: false)
    private(set) public var timeStamp: FitTime?
    
    public required init() {
        super.init()
        
        self.$timeStamp.owner = self
        
        self.$report.owner = self
        self.$temperature.owner = self
        self.$condition.owner = self
        self.$windDirection.owner = self
        self.$windSpeed.owner = self
        self.$precipitationProbability.owner = self
        self.$feelsLikeTemperature.owner = self
        self.$relativeHumidity.owner = self
        self.$location.owner = self
        self.$observedTime.owner = self
        self.$latitude.owner = self
        self.$longitude.owner = self
        self.$dayOfWeek.owner = self
        self.$highTemperature.owner = self
        self.$lowTemperature.owner = self
    }
    
    public convenience init(timeStamp: FitTime? = nil,
                            report: WeatherReport? = nil,
                            temperature: Measurement<UnitTemperature>? = nil,
                            condition: WeatherStatus? = nil,
                            windDirection: Measurement<UnitAngle>? = nil,
                            windSpeed: Measurement<UnitSpeed>? = nil,
                            precipitationProbability: UInt8? = nil,
                            feelsLikeTemperature: Measurement<UnitTemperature>? = nil,
                            relativeHumidity: UInt8? = nil,
                            location: String? = nil,
                            observedTime: FitTime? = nil,
                            observedLocation: Position? = nil,
                            dayOfWeek: DayOfWeek? = nil,
                            highTemperature: Measurement<UnitTemperature>? = nil,
                            lowTemperature: Measurement<UnitTemperature>? = nil) {
        self.init()
        
        if precipitationFitsRange() == false {
            precondition(true, "precipitationProbability must be between \(precipitationRange.lowerBound) and \(precipitationRange.upperBound).")
        }
        
        self.timeStamp = timeStamp
        
        self.report = report
        self.temperature = temperature
        self.condition = condition
        self.windDirection = windDirection
        self.windSpeed = windSpeed
        self.precipitationProbability = precipitationProbability
        self.feelsLikeTemperature = feelsLikeTemperature
        self.relativeHumidity = relativeHumidity
        self.location = location
        self.observedTime = observedTime
        self.observedLocation = observedLocation
        self.dayOfWeek = dayOfWeek
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
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
        
        let msg = WeatherConditionsMessage(fieldDict: fieldDict,
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
        
        guard precipitationFitsRange() else {
            return.failure(FitEncodingError.boundsError(title: "Precipitation Probability must be between",
                                                        range: precipitationRange))
        }
        
        guard location?.count ?? 0 <= UInt8.max else {
            return.failure(FitEncodingError.properySize("location size can not exceed 255"))
        }
        
        let fields = self.fieldDict.sorted { $0.key < $1.key }.map { $0.value }
        
        guard fields.isEmpty == false else { return.failure(self.encodeNoPropertiesAvailable()) }
        
        let defMessage = DefinitionMessage(architecture: .little,
                                           globalMessageNumber: WeatherAlertMessage.globalMessageNumber(),
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

private extension WeatherConditionsMessage {
    
    func precipitationFitsRange() -> Bool {
        
        if let precipitationProbability = precipitationProbability {
            return precipitationRange.contains(Int(precipitationProbability))
        }
        
        return true
    }
}
