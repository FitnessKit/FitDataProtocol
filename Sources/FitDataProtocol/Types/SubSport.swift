//
//  SubSport.swift
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


/// FIT Sub Sport
///
public enum SubSport: UInt8 {
    /// Generic
    case generic                = 1
    /// Treadmill - Run/Fitness Equipment
    case treadmill              = 2
    /// Street - run
    case street                 = 3
    /// Track - run
    case track                  = 4
    /// Spin - Cycling
    case spin                   = 5
    /// Indoor Cycling - Cycling/Fitness Equipment
    case indoorCycling          = 6
    /// Road - Cycling
    case road                   = 7
    /// Mountain - Cycling
    case mountain               = 8
    /// Downhill - Cycling
    case downhill               = 9
    /// Recumbent - Cycling
    case recumbent              = 10
    /// Cyclocross - Cycling
    case cyclocross             = 11
    /// Hand Cycling - Cycling
    case handCycling            = 12
    /// Track Cycling - Cycling
    case trackCycling           = 13
    /// Indoor Rowing - Fitness Equipment
    case indoorRowing           = 14
    /// Elliptical - Fitness Equipment
    case elliptical             = 15
    /// Stair Climbing - Fitness Eqiupment
    case stairClimbing          = 16
    /// Lap Swimming - Swimming
    case lapSwimming            = 17
    /// Open Water - Swimming
    case openWater              = 18
    /// Flexibility Training - Training
    case flexibilityTraining    = 19
    /// Strength Training - Training
    case strengthTraining       = 20
    /// Warm Up - Tennis
    case warmUp                 = 21
    /// Match - Tennis
    case match                  = 22
    /// Exercise - Tennis
    case exercise               = 23
    /// Challenge - Tenni
    case challenge              = 24
    /// Indoor Skiing - Fitness Equipment
    case indoorSkiing           = 25
    /// Cardio Training - Training
    case cardioTraining         = 26
    /// Indoor Walking = Walking/Fitness Equipment
    case indoorWalking          = 27
    /// E Bike Fitness - E-Biking
    case eBikeFitness           = 28
    /// BMX - Cycling
    case bmx                    = 29
    /// Casual Walking - Walking
    case casualWalking          = 30
    /// Speed Walking - Walking
    case speedWalking           = 31
    /// Bike to Run Transition - Transition
    case bikeRunTransition      = 32
    /// Run to Bike Transition - Transition
    case runBikeTransition      = 33
    /// Swim to Bike Transition - Transition
    case swimBikeTransition     = 34
    /// ATV - Motorcycling
    case atv                    = 35
    /// Motocross = Motorcycling
    case motocross              = 36
    /// Backcountry - Alpine Skiing/Snowboarding
    case backcountry            = 37
    /// Resort - Alpine Skiing/Snowboarding
    case resort                 = 38
    /// RC Drone - Flying
    case rcDrone                = 39
    /// Wingsuit - Flying
    case wingsuit               = 40
    /// Whitewater - Kayaking/Rafting
    case whitewater             = 41
    /// Skate Skiing = Cross Country Skiing
    case skateSkiing            = 42
    /// Yoga - Training
    case yoga                   = 43
    /// Pilates - Training
    case pilates                = 44
    /// Indoor Running - Run
    case indoorRunning          = 45
    /// Gravel Cycling - Cycling
    case gravelCycling          = 46
    /// E Bike Mountain - Cycling
    case eBikeMountain          = 47
    /// Commuting - Cycling
    case commuting              = 48
    /// Mixed Surface - Cycling
    case mixedSurface           = 49
    /// Navigate
    case navigate               = 50
    /// Track Me
    case trackMe                = 51
    /// Map
    case map                    = 52
    /// Single Gas Diving - Diving
    case singleGasDiving        = 53
    /// Multi Gas Diving - Diving
    case multiGasDiving         = 54
    /// Gauge Diving - Diving
    case gaugeDiving            = 55
    /// Apnea Diving - Diving
    case apneaDiving            = 57
    /// Virtual Activity - Used for events where participants run, crawl through mud, climb over walls, etc
    case virtualActivity        = 58
    /// All
    case all                    = 254
    /// Invalid
    case invalid                = 255
}
