//
//  FitMessageTests.swift
//  FitDataProtocolTests
//
//  Created by Kevin Hoogheem on 11/24/19.
//

import XCTest
@testable import FitDataProtocol
import FitnessUnits
import AntMessageProtocol

class FitMessageTests: XCTestCase {
    static var allTests = [
        ("testFileIdMessage", testFileIdMessage),
        ("testBloodPressureMessage", testBloodPressureMessage),
        ("testCadenceZoneMessage", testCadenceZoneMessage),
        ("testCourseMessage", testCourseMessage),
        ("testCoursePointMessage", testCoursePointMessage),
        ("testDeveloperDataIdMessage", testDeveloperDataIdMessage),
        ("testExerciseTitleMessage", testExerciseTitleMessage),
        ("testFieldDescriptionMessage", testFieldDescriptionMessage),
        ("testHrvMessage", testHrvMessage),
        ("testWeightScaleMessage", testWeightScaleMessage),
        ("testZonesTargetMessage", testZonesTargetMessage),
    ]
}

extension FitMessageTests {
    
    func testFileIdMessage() {
        let time = Date()
        
        let file = FileIdMessage(deviceSerialNumber: 55555,
                                 fileCreationDate: FitTime(date: time),
                                 manufacturer: Manufacturer.garmin,
                                 product: UInt16.max - 2,
                                 fileNumber: 22,
                                 fileType: FileType(rawValue: 4),
                                 productName: "Product Name")
        
        if let value = file.deviceSerialNumber {
            XCTAssertTrue(value == 55555)
        }
        if let value = file.fileCreationDate?.recordDate {
            let calendar = Calendar.current
            let valueComps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: value)
            let testComps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: time)
            
            XCTAssertTrue(valueComps == testComps, "\(value) != \(time)")
        }
        if let value = file.manufacturer {
            XCTAssertTrue(value == Manufacturer.garmin)
        }
        if let value = file.product {
            XCTAssertTrue(value == UInt16.max - 2)
        }
        if let value = file.fileType {
            XCTAssertTrue(value == FileType(rawValue: 4))
        }
        if let value = file.productName {
            XCTAssertTrue(value == "Product Name")
        }
        
    }
    
    func testBloodPressureMessage() {
        let fTime = FitTime(date: Date())
        let index = MessageIndex(isSelected: true, value: 399)
        let mmhg = Measurement(value: 10, unit: UnitPressure.bars)
        
        let msg = BloodPressureMessage(timeStamp: fTime,
                                       systolicPressure: mmhg,
                                       diastolicPressure: Measurement(value: 11, unit: UnitPressure.millimetersOfMercury),
                                       meanArterialPressure: Measurement(value: 12, unit: UnitPressure.millimetersOfMercury),
                                       mapSampleMean: Measurement(value: 13, unit: UnitPressure.millimetersOfMercury),
                                       mapMorningValues: Measurement(value: 14, unit: UnitPressure.millimetersOfMercury),
                                       mapEveningValues: Measurement(value: 44, unit: UnitPressure.millimetersOfMercury),
                                       heartRate: 55,
                                       heartRateType: HeartRateType.irregular,
                                       status: BloodPressureStatus.incompleteData,
                                       userProfileIndex: index)
        
        if let value = msg.systolicPressure {
            let testVal = value.converted(to: UnitPressure.bars)
            XCTAssertTrue(testVal.value == 9.99915)
            XCTAssertTrue(testVal.unit == UnitPressure.bars)
        }
        if let value = msg.diastolicPressure {
            XCTAssertTrue(value.value == 11.0)
        }
        if let value = msg.meanArterialPressure {
            XCTAssertTrue(value.value == 12.0)
        }
        if let value = msg.mapSampleMean {
            XCTAssertTrue(value.value == 13.0)
        }
        if let value = msg.mapMorningValues {
            XCTAssertTrue(value.value == 14.0)
        }
        if let value = msg.mapEveningValues {
            XCTAssertTrue(value.value == 44.0)
        }
        if let value = msg.heartRate {
            XCTAssertTrue(value.value == 55.0)
        }
        if let value = msg.heartRateType {
            XCTAssertTrue(value == HeartRateType.irregular)
        }
        if let value = msg.status {
            XCTAssertTrue(value == BloodPressureStatus.incompleteData)
        }
        if let value = msg.userProfileIndex {
            XCTAssertTrue(value == index)
        }
        
    }
    
    func testCadenceZoneMessage() {
        let index = MessageIndex(isSelected: true, value: 399)
        
        let msg = CadenceZoneMessage(messageIndex: index,
                                     name: "testCadenceZoneMessagetestCadenceZoneMessage",
                                     highLevel: 55)
        
        if let value = msg.messageIndex {
            XCTAssertTrue(value == index)
        }
        if let value = msg.name {
            XCTAssertTrue(value == "testCadenceZoneMessagetestCadenceZoneMessage")
        }
        if let value = msg.highLevel {
            XCTAssertTrue(value.value == 55)
        }
        
    }
    
    func testCourseMessage() {
        let msg = CourseMessage(name: "asdf",
                                capabilities: [.distance, .position],
                                sport: Sport.alpineSkiing,
                                subSport: SubSport.backcountry)
        
        if let value = msg.name {
            XCTAssertTrue(value == "asdf")
        }
        if let value = msg.capabilities {
            XCTAssertTrue(value == [.distance, .position])
        }
        if let value = msg.sport {
            XCTAssertTrue(value == Sport.alpineSkiing)
        }
        if let value = msg.subSport {
            XCTAssertTrue(value == SubSport.backcountry)
        }
    }
    
    func testCoursePointMessage() {
        let fTime = FitTime(date: Date())
        let index = MessageIndex(isSelected: true, value: 399)
        
        let pos = Position(latitude: Measurement(value: 40, unit: UnitAngle.garminSemicircle),
                           longitude: Measurement(value: 80, unit: UnitAngle.garminSemicircle))
        
        let msg = CoursePointMessage(timeStamp: fTime,
                                     messageIndex: index,
                                     name: "name",
                                     position: pos,
                                     distance: Measurement(value: 44, unit: UnitLength.meters),
                                     pointType: CoursePoint.danger,
                                     isFavorite: true)
        
        if let value = msg.messageIndex {
            XCTAssertTrue(value.index == 399)
        }
        if let value = msg.name {
            XCTAssertTrue(value == "name")
        }
        if let value = msg.position {
            XCTAssertTrue(value.latitude?.unit == UnitAngle.garminSemicircle)
            XCTAssertTrue(value.latitude?.value == 40)
            XCTAssertTrue(value.longitude?.unit == UnitAngle.garminSemicircle)
            XCTAssertTrue(value.longitude?.value == 80)
        }
    }
    
    func testDeveloperDataIdMessage() {
        let dev = Data([0x00, 0x01])
        let app = Data([0x00, 0x01, 0x02, 0x03, 0x04])
        
        let msg = DeveloperDataIdMessage(developerId: dev,
                                         applicationId: app,
                                         applicationVersion: 5555,
                                         manufacturer: Manufacturer.wahooFitness,
                                         dataIndex: 8)
        
        if let value = msg.developerId {
            XCTAssertTrue(value == dev)
        }
        if let value = msg.applicationId {
            XCTAssertTrue(value == app)
        }
        if let value = msg.applicationVersion {
            XCTAssertTrue(value == 5555)
        }
        if let value = msg.manufacturer {
            XCTAssertTrue(value == Manufacturer.wahooFitness)
        }
        if let value = msg.dataIndex {
            XCTAssertTrue(value == 8)
        }
        
    }
    
    func testExerciseTitleMessage() {
        let index = MessageIndex(isSelected: true, value: 399)
        
        let press = CoreExerciseName.bodyBarObliqueTwist
        let cat = ExerciseCategory.core
        
        let msg = ExerciseTitleMessage(messageIndex: index,
                                       stepName: "runStepRun",
                                       category: cat,
                                       exerciseName: press)
        
        if let value = msg.messageIndex {
            XCTAssertTrue(value.index == 399)
        }
        if let value = msg.stepName {
            XCTAssertTrue(value == "runStepRun")
        }
        if let value = msg.category {
            XCTAssertTrue(value == cat)
        }
        if let value = msg.exerciseName {
            XCTAssertTrue(value.catagory == press.catagory)
            XCTAssertTrue(value.catagory == cat)
            XCTAssertTrue(value.name == press.name)
            XCTAssertTrue(value.number == press.number)
        }
    }
    
    func testFieldDescriptionMessage() {
        let base = BaseTypeData(type: .uint8, resolution: Resolution(scale: 1, offset: 0))
        
        let msg = FieldDescriptionMessage(dataIndex: 0,
                                          definitionNumber: 1,
                                          fieldName: "Bannana",
                                          baseInfo: base,
                                          units: "bunches",
                                          baseUnits: .other,
                                          messageNumber: 4,
                                          fieldNumber: 5)
                
        if let value = msg.dataIndex {
            XCTAssertTrue(value == 0)
        }
        if let value = msg.definitionNumber {
            XCTAssertTrue(value == 1)
        }
        if let value = msg.fieldName {
            XCTAssertTrue(value == "Bannana")
        }
        if let value = msg.baseInfo {
            XCTAssertTrue(value.type == base.type)
            XCTAssertTrue(value.resolution.scale == base.resolution.scale)
            XCTAssertTrue(value.resolution.offset == base.resolution.offset)
        }
        if let value = msg.units {
            XCTAssertTrue(value == "bunches")
        }
        if let value = msg.baseUnits {
            XCTAssertTrue(value == .other)
        }
        if let value = msg.messageNumber {
            XCTAssertTrue(value == 4)
        }
        if let value = msg.fieldNumber {
            XCTAssertTrue(value == 5)
        }

    }
    
    func testHrvMessage() {
        
        let hrvs = [
            Measurement(value: 0.65, unit: UnitDuration.seconds),
            Measurement(value: 5.632, unit: UnitDuration.seconds),
            Measurement(value: 0.100, unit: UnitDuration.seconds),
            Measurement(value: 0.100, unit: UnitDuration.seconds),
            Measurement(value: 1.234, unit: UnitDuration.seconds),
        ]
        
        let msg = HrvMessage(hrv: hrvs)
        
        if let value = msg.hrv {
            XCTAssertTrue(value.count == hrvs.count)
        }
        if let value = msg.hrv?.first {
            XCTAssertTrue(value.value == hrvs.first?.value)
        }
        if let value = msg.hrv?.last {
            XCTAssertTrue(value.value == hrvs.last?.value)
        }
    }
    
    func testWeightScaleMessage() {
        let fTime = FitTime(date: Date())
        let index = MessageIndex(isSelected: true, value: 399)
        
        let weight = Weight(weight: Measurement(value: 50, unit: UnitMass.kilograms), calculating: false)
        
        let msg = WeightScaleMessage(timeStamp: fTime,
                                     weight: weight,
                                     userProfileIndex: index)
        
        if let value = msg.userProfileIndex {
            XCTAssertTrue(value == index)
        }
        if let value = msg.weight {
            XCTAssertTrue(value == weight)
        }
        
        let calcWeight = Weight(weight: nil, calculating: true)
        
        let msgCalc = WeightScaleMessage(timeStamp: fTime,
                                         weight: calcWeight,
                                         userProfileIndex: index)
        
        if let value = msgCalc.userProfileIndex {
            XCTAssertTrue(value == index)
        }
        if let value = msgCalc.weight {
            XCTAssertTrue(value == calcWeight)
        }
        
    }
    func testZonesTargetMessage() {
        
        let target = ZonesTargetMessage(maxHeartRate: 55,
                                        thresholdHeartRate: 200,
                                        heartRateZoneType: HeartRateZoneCalculation.percentMax,
                                        ftp: 55,
                                        powerZoneType: PowerZoneCalculation.percentFtp)
        
        if let value = target.maxHeartRate {
            XCTAssertTrue(value.value == 55.0)
        }
        if let value = target.thresholdHeartRate {
            XCTAssertTrue(value.value == 200.0)
        }
        if let value = target.heartRateZoneType {
            XCTAssertTrue(value == HeartRateZoneCalculation.percentMax)
        }
        if let value = target.ftp {
            XCTAssertTrue(value == 55)
        }
        if let value = target.powerZoneType {
            XCTAssertTrue(value == PowerZoneCalculation.percentFtp)
        }
    }
    
}
