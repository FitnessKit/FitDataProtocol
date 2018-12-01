//
//  FileType.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/20/18.
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

/// FIT File Type
public struct FileType {

    /// Raw Value for File Type
    public let rawValue: UInt8

    /// Manufacturing Speciic Range Check
    public var isManufacturingType: Bool {
        let range = ClosedRange(uncheckedBounds: (lower: 0xF7, upper: 0xFE))

        if range.contains(Int(rawValue)) == true  {
            return true
        }

        return false
    }

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }

}

extension FileType: Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: FileType, rhs: FileType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

extension FileType: Hashable {

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    public var hashValue: Int {
        return rawValue.hashValue
    }

}


//MARK: Types
public extension FileType {

    /// Non FIT File
    public static let nonFitFile = FileType(rawValue: 0)

    /// Device - Read only, single File
    ///
    /// The device file contains data records that provide information on a device’s
    /// file structure/capabilities. The records provide details on the types of files
    /// a device supports, and restrictions/capabilities (if applicable) of the messages
    /// and fields contained within each file type.
    public static let device = FileType(rawValue: 1)

    /// Settings - Read/Write, single File
    ///
    /// The settings file contains data records that provide user and device information
    /// in the form of profiles. Each profile is grouped into either user, bike, or specific
    /// device profiles (such as HRMs, SDMs and activity monitors). The profiles provide
    /// information about the user, bicycle, sensors that a device may pair to, and user
    /// interface preferences.
    public static let settings = FileType(rawValue: 2)

    /// Sport - Read/write, multiple files
    ///
    /// The sports settings file contains information about the user’s desired target zones.
    /// The records provide details on the types of zones supported (such as heart rate or power),
    /// and the desired target levels. The sports settings file allows these values to be grouped by sport.
    public static let sport = FileType(rawValue: 3)

    /// Activity - Read/write/erase, multiple files
    ///
    /// Activity files are used to record sensor data and events from an active session
    public static let activity = FileType(rawValue: 4)

    /// Workout - Read/write/erase, multiple files
    ///
    /// A workout file describes a structured activity and guides a user through the activity.
    /// It can be designed on a computer and transferred to a display device or generated on the device itself.
    public static let workout = FileType(rawValue: 5)

    /// Course - Read/write/erase, multiple files
    ///
    /// A course file contains data from a recorded activity that can be transferred to a display
    /// device to guide a user through the same activity.
    public static let course = FileType(rawValue: 6)

    /// Schedules - Read/write, single file
    ///
    /// Schedule files are used to schedule a user’s workouts and may contain multiple schedule
    /// messages each representing the start time of a workout.
    public static let schedules = FileType(rawValue: 7)

    /// Weight - Read, single file
    ///
    /// A weight file is similar in structure to the blood pressure file type. A weight file
    /// contains time-stamped discrete measurement data that is reported after measurement.
    /// The file is organized such that all definition messages are declared first, prior to
    /// recording any weight messages. No definition messages should appear after weight data
    /// messages have been recorded. To link multiple data messages in a weight file, they must
    /// have identical timestamps.
    public static let weight = FileType(rawValue: 9)

    /// Totals - Read, single file
    ///
    /// Totals files are used to summarize a user’s activities and may contain multiple totals
    /// messages each representing summaries of a different activity type/sport.
    public static let totals = FileType(rawValue: 10)

    /// Goals - Read/write, single file
    ///
    /// Goals files allow a user to communicate their exercise/health goals. Goals may be set for
    /// a variety of activities, over specific periods of time, and with desired targets set according
    /// to total duration, calories consumed, distance travelled, number of steps taken and/or frequency of activity.
    public static let goals = FileType(rawValue: 11)

    /// Blood Pressure - Read
    public static let bloodPressure = FileType(rawValue: 14)

    /// Monitoring A - Read
    public static let monitoringA = FileType(rawValue: 15)

    /// Activity Summary - Read/erase
    ///
    /// Activity summary files are a compact version of the activity file.
    public static let activitySummary = FileType(rawValue: 20)

    /// Monitoring Daily
    public static let monitoringDaily = FileType(rawValue: 28)

    /// Monitoring B - Read
    public static let monitoringB = FileType(rawValue: 32)

    /// Segment - Read/write/erase
    ///
    /// Segment files contain data defining a route and timing information to gauge progress
    /// against previous performances or other users.
    public static let segment = FileType(rawValue: 34)

    /// Segment List - Read/write/erase
    ///
    /// Segment List files maintain a list of available segments on the device.
    public static let segmentList = FileType(rawValue: 35)

    /// Extd Configuration - Read/write/erase
    public static let extdConfiguration = FileType(rawValue: 40)

    /// Invalid
    public static let invalid = FileType(rawValue: 255)
} 
