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
    public static let device = FileType(rawValue: 1)

    /// Settings - Read/Write, single File
    public static let settings = FileType(rawValue: 2)

    /// Sport - Read/write, multiple files
    public static let sport = FileType(rawValue: 3)

    /// Activity - Read/write/erase, multiple files
    public static let activity = FileType(rawValue: 4)

    /// Workout - Read/write/erase, multiple files
    public static let workout = FileType(rawValue: 5)

    /// Course - Read/write/erase, multiple files
    public static let course = FileType(rawValue: 6)

    /// Schedules - Read/write, single file
    public static let schedules = FileType(rawValue: 7)

    /// Weight - Read, single file
    public static let weight = FileType(rawValue: 9)

    /// Totals - REad, single file
    public static let totals = FileType(rawValue: 10)

    /// Goals - Read/write, single file
    public static let goals = FileType(rawValue: 11)

    /// Blood Pressure - Read
    public static let bloodPressure = FileType(rawValue: 14)

    /// Monitoring A - Read
    public static let monitoringA = FileType(rawValue: 15)

    /// Activity Summary - Read/erase
    public static let activitySummary = FileType(rawValue: 20)

    /// Monitoring Daily
    public static let monitoringDaily = FileType(rawValue: 28)

    /// Monitoring B - Read
    public static let monitoringB = FileType(rawValue: 32)

    /// Segment - Read/write/erase
    public static let segment = FileType(rawValue: 34)

    /// Segment List - Read/write/erase
    public static let segmentList = FileType(rawValue: 35)

    /// Extd Configuration - Read/write/erase
    public static let extdConfiguration = FileType(rawValue: 40)

    /// Invalid
    public static let invalid = FileType(rawValue: 255)
} 
