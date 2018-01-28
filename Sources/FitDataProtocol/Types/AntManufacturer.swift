//
//  AntManufacturer.swift
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

///ANT Manufacturer
///
public enum AntManufacturer: UInt16 {
    case unknown                = 0
    case garmin                 = 1
    case garminFR405            = 2
    case zephyr                 = 3
    case dayton                 = 4
    case idt                    = 5
    case srm                    = 6
    case quarq                  = 7
    case iBike                  = 8
    case saris                  = 9
    case spartHK                = 10
    case tanita                 = 11
    case echowell               = 12
    case dynastreamOem          = 13
    case nautilus               = 14
    case dynastream             = 15
    case timex                  = 16
    case metrigear              = 17
    case xelic                  = 18
    case beurer                 = 19
    case cardioSport            = 20
    case aAndD                  = 21  //looks bad.. is there a better way to do (A & D)
    case hmm                    = 22
    case suunto                 = 23
    case thitaElektronik        = 24
    case gPulse                 = 25
    case cleanMobile            = 26
    case pedalBrain             = 27
    case peaksware              = 28
    case saxonar                = 29
    case lemondFitness          = 30
    case dexcom                 = 31
    case wahooFitness           = 32
    case octaneFitness          = 33
    case archinoetics           = 34
    case theHurtBox             = 35
    case citizenSystems         = 36
    case magellan               = 37
    case osynce                 = 38
    case holux                  = 39
    case concept2               = 40
    case oneGiantLeap           = 42
    case aceSensor              = 43
    case brimBrothers           = 44
    case xplova                 = 45
    case perceptionDigital      = 46
    case bf1Systems             = 47
    case pioneer                = 48
    case spantec                = 49
    case metalogics             = 50
    case fouriii                = 51
    case seikoEpson             = 52
    case seikoEpsonOem          = 53
    case iForPowell             = 54
    case maxwellGuider          = 55
    case starTrac               = 56
    case breakaway              = 57
    case alatechTechnology      = 58
    case mioTechnologyEurope    = 59
    case rotor                  = 60
    case geonaute               = 61
    case idBike                 = 62
    case specialized            = 63
    case wTek                   = 64
    case physicalEnterprises    = 65
    case northPoleEngineering   = 66
    case bKool                  = 67
    case cateye                 = 68
    case stagesCycling          = 69
    case sigmaSport             = 70
    case tomTom                 = 71
    case peripedal              = 72
    case wattBike               = 73
    ///74-75 left blank
    case moxy                   = 76
    case cicloSport             = 77
    case powerBahn              = 78
    case acornProjectAps        = 79
    case lifeBeam               = 80
    case bontrager              = 81
    case wellgo                 = 82
    case scosche                = 83
    case magura                 = 84
    case woodway                = 85
    case elite                  = 86
    case nielsenKellerman       = 87
    case dkCity                 = 88
    case tacx                   = 89
    case directionTechnology    = 90
    case magtonic               = 91
    case onePartCarbon          = 92
    case insideRide             = 93
    case soundOfMotion          = 94
    case stryd                  = 95
    case indoorCyclingGroup     = 96
    case miPulse                = 97
    case bsxAthletics           = 98
    case look                   = 99
    case campagnolo             = 100
    case bodyBikeSmart          = 101
    case praxisworks            = 102
    case limitsTechnology       = 103
    case topActionTechnology    = 104
    case cosinuss               = 105
    case fitCare                = 106
    case magene                 = 107
    case giantManufacturing     = 108
    case tigraSport             = 109
    case salutron               = 110
    case technogym              = 111
    case brytonSensors          = 112
    case latitudeLimited        = 113
    case soaringTechnology      = 114
    case igpSport               = 115
    ///116-254 left blank
    case development            = 255
    case healthAndLife          = 257
    case lezyne                 = 258
    case scribeLabs             = 259
    case zwift                  = 260
    case watteam                = 261
    case recon                  = 262
    case faveroElectronics      = 263
    case dynoVelo               = 264
    case strava                 = 265
    case precore                = 266
    case byrton                 = 267
    case sram                   = 268
    case mioTechnology          = 269
    case cobi                   = 270
    case spivi                  = 271
    case mioMagellan            = 272
    case eveSports              = 273
    case sensitivusGauge        = 274
    case podoon                 = 275
    case lifeTimeFitness        = 276
    case falcoEMotors           = 277
    case minoura                = 278
    case cycliq                 = 279
    case luxottica              = 280
    case trainerRoad            = 281
    case theSufferfest          = 282
    ///283-5768 left blank
    case actiGraph              = 5769
}


public extension AntManufacturer {

    public var stringValue: String {

        switch self {
        case .unknown:
            return "Unknown"

        case .garmin:
            return "Garmin"

        case .garminFR405:
            return "Garmin FR405 ANTFS"

        case .zephyr:
            return "Zephyr"

        case .dayton:
            return "Dayton"

        case .idt:
            return "IDT"

        case .srm:
            return "SRM"

        case .quarq:
            return "Quarq"

        case .iBike:
            return "iBike"

        case .saris:
            return "Saris"

        case .spartHK:
            return "Spart HK"

        case .tanita:
            return "Tanita"

        case .echowell:
            return "Echowell"

        case .dynastreamOem:
            return "Dynastream OEM"

        case .nautilus:
            return "Nautilus"

        case .dynastream:
            return "Dynastream"

        case .timex:
            return "Timex"

        case .metrigear:
            return "Metrigear"

        case .xelic:
            return "Xelic"

        case .beurer:
            return "Beurer"

        case .aAndD:
            return "A & D"

        case .hmm:
            return "HMM"

        case .suunto:
            return "SUUNTO"

        case .thitaElektronik:
            return "Thita Elektonik"

        case .gPulse:
            return "G.Pulse"

        case .cleanMobile:
            return "Clean Mobile"

        case .pedalBrain:
            return "Pedal Brain"

        case .peaksware:
            return "Peaksware"

        case .saxonar:
            return "Saxonar"

        case .lemondFitness:
            return "Lemond Fitness"

        case .dexcom:
            return "Dexcom"

        case .wahooFitness:
            return "Wahoo Fitness"

        case .octaneFitness:
            return "Octane Fitness"

        case .archinoetics:
            return "Archinoetics"

        case .theHurtBox:
            return "The Hurt Box"

        case .citizenSystems:
            return "Citizen Systems"

        case .magellan:
            return "Magellen"

        case .osynce:
            return "Osynce"

        case .holux:
            return "Holux"

        case .concept2:
            return "Concept2"

        case .oneGiantLeap:
            return "One Giant Leap"

        case .aceSensor:
            return "Ace Sensor"

        case .brimBrothers:
            return "Brim Bothers"

        case .xplova:
            return "Xplova"

        case .perceptionDigital:
            return "Perception Digital"

        case .bf1Systems:
            return "bf1systems Ltd"

        case .pioneer:
            return "Pioneer"

        case .spantec:
            return "Spantec"

        case .metalogics:
            return "Metalogics"

        case .fouriii:
            return "4IIII Innovations Inc."

        case .seikoEpson:
            return "Seiko Epson"

        case .seikoEpsonOem:
            return "Seiko Epson OEM"

        case .iForPowell:
            return "IFor Powell"

        case .maxwellGuider:
            return "Maxwell Guider"

        case .starTrac:
            return "Star Trac"

        case .breakaway:
            return "Breakaway"

        case .alatechTechnology:
            return "Alatech Technology LTD."

        case .mioTechnologyEurope:
            return "MIO Technology Europe"

        case .rotor:
            return "Rotor"

        case .geonaute:
            return "Geonaute"

        case .idBike:
            return "ID Bike"

        case .specialized:
            return "Specialized"

        case .wTek:
            return "WTek"

        case .physicalEnterprises:
            return "Physical Enterprises"

        case .northPoleEngineering:
            return "North Pole Engineering"

        case .bKool:
            return "BKool"

        case .cateye:
            return "Cateye"

        case .stagesCycling:
            return "Stages Cycling"

        case .sigmaSport:
            return "SIGMA SPORT"

        case .tomTom:
            return "Tom Tom"

        case .peripedal:
            return "Peripedal"

        case .wattBike:
            return "Wattbike"

        case .moxy:
            return "MOXY"

        case .cicloSport:
            return "CicloSport"

        case .powerBahn:
            return "POWERbahn"

        case .acornProjectAps:
            return "Acorn Project Aps."

        case .lifeBeam:
            return "LifeBEAM"

        case .bontrager:
            return "Bontrager"

        case .wellgo:
            return "Wellgo"

        case .scosche:
            return "Scosche"

        case .magura:
            return "MAGURA"

        case .woodway:
            return "Woodway"

        case .elite:
            return "Elite"

        case .nielsenKellerman:
            return "Nielsen-Kellerman"

        case .dkCity:
            return "DK City"

        case .tacx:
            return "Tacx"

        case .directionTechnology:
            return "Direction Technology"

        case .magtonic:
            return "Magtonic"

        case .onePartCarbon:
            return "1partCarbon Inc."

        case .insideRide:
            return "Inside Ride"

        case .soundOfMotion:
            return "Sound Of Motion"

        case .stryd:
            return "Stryd"

        case .indoorCyclingGroup:
            return "Indoor Cycling Group"

        case .miPulse:
            return "Mi Pulse"

        case .bsxAthletics:
            return "BSX Athletics"

        case .look:
            return "Look"

        case .campagnolo:
            return "Campagnolo Srl"

        case .bodyBikeSmart:
            return "Body Bike Smart"

        case .praxisworks:
            return "Praxisworks"

        case .limitsTechnology:
            return "Limits Technology"

        case .topActionTechnology:
            return "TopAction Technology"

        case .cosinuss:
            return "Cosinuss"

        case .fitCare:
            return "Fitcare"

        case .magene:
            return "Magene"

        case .giantManufacturing:
            return "Giant Manufacturing Co"

        case .tigraSport:
            return "TiGRA Sport"

        case .salutron:
            return "Salutron"

        case .technogym:
            return "TechnoGym"

        case .brytonSensors:
            return "Bryton Sensors"

        case .latitudeLimited:
            return "Latitude Limited"

        case .soaringTechnology:
            return "Soaring Technology"

        case .igpSport:
            return "IGP Sports"

        case .development:
            return "Development"

        case .healthAndLife:
            return "Health And Life"

        case .lezyne:
            return "Lezyne"

        case .scribeLabs:
            return "Scribe Labs"
            
        case .zwift:
            return "Zwift"
            
        case .watteam:
            return "Watteam"
            
        case .recon:
            return "Recon"
            
        case .faveroElectronics:
            return "Favero Electronics"
            
        case .dynoVelo:
            return "Dyno Velo"
            
        case .strava:
            return "Strava"
            
        case .byrton:
            return "Bryton"
            
        case .sram:
            return "SRAM"
            
        case .mioTechnology:
            return "Mio Technology"
            
        case .cobi:
            return "COBI GmbH"
            
        case .spivi:
            return "Spivi"
            
        case .mioMagellan:
            return "Mio Magellan"
            
        case .eveSports:
            return "Eve Sports"
            
        case .sensitivusGauge:
            return "Sensitivus Gauge"
            
        case .podoon:
            return "Podoon"
            
        case .lifeTimeFitness:
            return "Life Time Fitness"

        case .falcoEMotors:
            return "Falco E-Motors"

        case .minoura:
            return "Minoura"

        case .cycliq:
            return "Cycliq"

        case .luxottica:
            return "Luxottica"

        case .trainerRoad:
            return "Trainer Road"

        case .theSufferfest:
            return "The Sufferfest"
            
        case .actiGraph:
            return "ActiGraph"
            
        default:
            return "Unknown"
        }
    }
}
