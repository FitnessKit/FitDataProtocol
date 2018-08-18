//
//  RecordMessageKeys.swift
//  AntMessageProtocol
//
//  Created by Kevin Hoogheem on 8/18/18.
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

@available(swift 4.0)
@available(iOS 10.0, tvOS 10.0, watchOS 3.0, OSX 10.12, *)
extension RecordMessage: FitMessageKeys {
    public typealias FitCodingKeys = MessageKeys

    /// FIT Message Keys
    ///
    public enum MessageKeys: Int, CodingKey {
        case positionLatitude                   = 0
        case positionLongitude                  = 1
        case altitude                           = 2
        case heartRate                          = 3
        case cadence                            = 4
        case distance                           = 5
        case speed                              = 6
        case power                              = 7
        case compressedSpeedDistance            = 8
        case grade                              = 9
        case resistance                         = 10
        case timeFromCourse                     = 11
        case cycleLength                        = 12
        case temperature                        = 13
        case speedOneSecondInterval             = 17
        case cycles                             = 18
        case totalCycles                        = 19
        case compressedAccumulatedPower         = 28
        case accumulatedPower                   = 29
        case leftRightBalance                   = 30
        case gpsAccuracy                        = 31
        case verticalSpeed                      = 32
        case calories                           = 33
        case verticalOscillation                = 39
        case stanceTimePercent                  = 40
        case stanceTime                         = 41
        case activityType                       = 42
        case leftTorqueEffectiveness            = 43
        case rightTorqueEffectiveness           = 44
        case leftPedalSmoothness                = 45
        case rightPedalSmoothness               = 46
        case combinedPedalSmoothness            = 47
        case time128Second                      = 48
        case strokeType                         = 49
        case zone                               = 50
        case ballSpeed                          = 51
        case cadence256                         = 52
        case fractionalCadence                  = 53
        case totalHemoglobinConcentration       = 54
        case totalHemoglobinConcentrationMin    = 55
        case totalHemoglobinConcentrationMax    = 56
        case saturatedHemoglobinPercent         = 57
        case saturatedHemoglobinPercentMin      = 58
        case saturatedHemoglobinPercentMax      = 59
        case deviceIndex                        = 62
        case enhancedSpeed                      = 73
        case enhancedAltitude                   = 78

        case timestamp                          = 253
    }
}
