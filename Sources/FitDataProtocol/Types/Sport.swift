//
//  Sport.swift
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

/// FIT Sport Types
///
public enum Sport: UInt8 {
    case generic                = 0
    case running                = 1
    case cycling                = 2
    case multisportTransition   = 3
    case fitnessEquipment       = 4
    case swimming               = 5
    case basketball             = 6
    case soccer                 = 7
    case tennis                 = 8
    case americanFootball       = 9
    case training               = 10
    case walking                = 11
    case crossCountrySkiing     = 12
    case alpineSkiing           = 13
    case snowboarding           = 14
    case rowing                 = 15
    case mountaineering         = 16
    case hiking                 = 17
    case mulitsport             = 18
    case paddling               = 19
    case flying                 = 20
    case eBiking                = 21
    case motorcycling           = 22
    case boating                = 23
    case driving                = 24
    case golf                   = 25
    case hangGliding            = 26
    case horsebackRiding        = 27
    case hunting                = 28
    case fishing                = 29
    case inlineSkating          = 30
    case rockClimbing           = 31
    case sailing                = 32
    case iceSkating             = 33
    case skyDiving              = 34
    case snowshoeing            = 35
    case snowmobiling           = 36
    case standUpPaddelboarding  = 37
    case surfing                = 38
    case wakeboarding           = 39
    case waterSkiing            = 40
    case kayaking               = 41
    case rafting                = 42
    case windSurfing            = 43
    case kiteSurfing            = 44
    case tactical               = 45
    case jumpMaster             = 46
    case boxing                 = 47
    case floorClimbing          = 48
    case all                    = 254
    case invalid                = 255
}

extension Sport {

    public var stringValue: String {
        switch self {
        case .generic:
            return "Generic"
        case .running:
            return "Running"
        case .cycling:
            return "Cycling"
        case .multisportTransition:
            return "Multi-Sport Transition"
        case .fitnessEquipment:
            return "Fitness Equipment"
        case .swimming:
            return "Swimming"
        case .basketball:
            return "Basketball"
        case .soccer:
            return "Soccer"
        case .tennis:
            return "Tennis"
        case .americanFootball:
            return "American Football"
        case .training:
            return "Training"
        case .walking:
            return "Walking"
        case .crossCountrySkiing:
            return "Cross Country Skiing"
        case .alpineSkiing:
            return "Alpine Skiing"
        case .snowboarding:
            return "Snow Boarding"
        case .rowing:
            return "Rowing"
        case .mountaineering:
            return "Mountaineering"
        case .hiking:
            return "Hiking"
        case .mulitsport:
            return "Multisport"
        case .paddling:
            return "Paddling"
        case .flying:
            return "Flying"
        case .eBiking:
            return "eBiking"
        case .motorcycling:
            return "Motorcycling"
        case .boating:
            return "Boating"
        case .driving:
            return "Driving"
        case .golf:
            return "Golf"
        case .hangGliding:
            return "Hang Gliding"
        case .horsebackRiding:
            return "Horseback Riding"
        case .hunting:
            return "Hunting"
        case .fishing:
            return "Fishing"
        case .inlineSkating:
            return "Inline Skating"
        case .rockClimbing:
            return "Rock Climbing"
        case .sailing:
            return "Sailing"
        case .iceSkating:
            return "Ice Skating"
        case .skyDiving:
            return "Sky Diving"
        case .snowshoeing:
            return "Snowshoeing"
        case .snowmobiling:
            return "Snowmobiling"
        case .standUpPaddelboarding:
            return "Stand Up Paddel Boarding"
        case .surfing:
            return "Surfing"
        case .wakeboarding:
            return "Wakeboarding"
        case .waterSkiing:
            return "Water Skiing"
        case .kayaking:
            return "Kayaking"
        case .rafting:
            return "Rafting"
        case .windSurfing:
            return "Wind Surfing"
        case .kiteSurfing:
            return "Kite Surfing"
        case .tactical:
            return "Tactical"
        case .jumpMaster:
            return "Jump Master"
        case .boxing:
            return "Boxing"
        case .floorClimbing:
            return "Floor Climbing"
        case .all:
            return "All"
        default:
            return "Unknown"
        }

    }

}
