//
//  ManufacturerExtension.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 11/11/17.
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
public extension Manufacturer {

    /// Unknown ID
    public class var unknown: Manufacturer { return Manufacturer(id: 0, name: "Unknown") }
    /// Development ID
    public class var development: Manufacturer { return Manufacturer(id: 255, name: "Development") }


    /// Garmin
    public class var garmin: Manufacturer { return Manufacturer(id: 1, name: "Garmin") }
    /// Garmin FR405 ANTFS
    public class var garminFR405: Manufacturer { return Manufacturer(id: 2, name: "Garmin FR405 ANTFS") }
    /// Zephyr
    public class var zephyr: Manufacturer { return Manufacturer(id: 3, name: "Zephyr") }
    /// Dayton
    public class var dayton: Manufacturer { return Manufacturer(id: 4, name: "Dayton") }
    /// IDT
    public class var idt: Manufacturer { return Manufacturer(id: 5, name: "IDT") }
    /// SRM
    public class var srm: Manufacturer { return Manufacturer(id: 6, name: "SRM") }
    /// Quarq
    public class var quarq: Manufacturer { return Manufacturer(id: 7, name: "Quarq") }
    /// iBike
    public class var iBike: Manufacturer { return Manufacturer(id: 8, name: "iBike") }
    /// Saris
    public class var saris: Manufacturer { return Manufacturer(id: 9, name: "Saris") }
    /// Spart HK
    public class var spartHK: Manufacturer { return Manufacturer(id: 10, name: "Spart HK") }
    /// Tanita
    public class var tanita: Manufacturer { return Manufacturer(id: 11, name: "Tanita") }
    /// Echowell
    public class var echowell: Manufacturer { return Manufacturer(id: 12, name: "Echowell") }
    /// Dynastream OEM
    public class var dynastreamOem: Manufacturer { return Manufacturer(id: 13, name: "Dynastream OEM") }
    /// Nautilus
    public class var nautilus: Manufacturer { return Manufacturer(id: 14, name: "Nautilus") }
    /// Dynastream
    public class var dynastream: Manufacturer { return Manufacturer(id: 15, name: "Dynastream") }
    /// Timex
    public class var timex: Manufacturer { return Manufacturer(id: 16, name: "Timex") }
    /// Metrigear
    public class var metrigear: Manufacturer { return Manufacturer(id: 17, name: "Metrigear") }
    /// Xelic
    public class var xelic: Manufacturer { return Manufacturer(id: 18, name: "Xelic") }
    /// Beurer
    public class var beurer: Manufacturer { return Manufacturer(id: 19, name: "Beurer") }
    /// Cardiosport
    public class var cardioSport: Manufacturer { return Manufacturer(id: 20, name: "Cardiosport") }
    /// A & D
    public class var aAndD: Manufacturer { return Manufacturer(id: 21, name: "A & D") }
    /// HMM
    public class var hmm: Manufacturer { return Manufacturer(id: 22, name: "HMM") }
    /// SUUNTO
    public class var suunto: Manufacturer { return Manufacturer(id: 23, name: "SUUNTO") }
    /// Thita Elektronik
    public class var thitaElektronik: Manufacturer { return Manufacturer(id: 24, name: "Thita Elektronik") }
    /// G.Pulse
    public class var gPulse: Manufacturer { return Manufacturer(id: 25, name: "G.Pulse") }
    /// Clean Mobile
    public class var cleanMobile: Manufacturer { return Manufacturer(id: 26, name: "Clean Mobile") }
    /// Pedal Brain
    public class var pedalBrain: Manufacturer { return Manufacturer(id: 27, name: "Pedal Brain") }
    /// Peaksware
    public class var peaksware: Manufacturer { return Manufacturer(id: 28, name: "Peaksware") }
    /// Saxonar
    public class var saxonar: Manufacturer { return Manufacturer(id: 29, name: "Saxonar") }
    /// Lemond Fitness
    public class var lemondFitness: Manufacturer { return Manufacturer(id: 30, name: "Lemond Fitness") }
    /// Dexcom
    public class var dexcom: Manufacturer { return Manufacturer(id: 31, name: "Dexcom") }
    /// Wahoo Fitness
    public class var wahooFitness: Manufacturer { return Manufacturer(id: 32, name: "Wahoo Fitness") }
    /// Octane Fitness
    public class var octaneFitness: Manufacturer { return Manufacturer(id: 33, name: "Octane Fitness") }
    /// Archinoetics
    public class var archinoetics: Manufacturer { return Manufacturer(id: 34, name: "Archinoetics") }
    /// The Hurt Box
    public class var theHurtBox: Manufacturer { return Manufacturer(id: 35, name: "The Hurt Box") }
    /// Citizen Systems
    public class var citizenSystems: Manufacturer { return Manufacturer(id: 36, name: "Citizen Systems") }
    /// Magellan
    public class var magellan: Manufacturer { return Manufacturer(id: 37, name: "Magellan") }
    /// Osynce
    public class var osynce: Manufacturer { return Manufacturer(id: 38, name: "Osynce") }
    /// Holux
    public class var holux: Manufacturer { return Manufacturer(id: 39, name: "Holux") }
    /// Concept2
    public class var concept2: Manufacturer { return Manufacturer(id: 40, name: "Concept2") }

    // 41 Left Blank

    /// One Giant Leap
    public class var oneGiantLeap: Manufacturer { return Manufacturer(id: 42, name: "One Giant Leap") }
    /// Ace Sensor
    public class var aceSensor: Manufacturer { return Manufacturer(id: 43, name: "Ace Sensor") }
    /// Brim Brothers
    public class var brimBrothers: Manufacturer { return Manufacturer(id: 44, name: "Brim Brothers") }
    /// Xplova
    public class var xplova: Manufacturer { return Manufacturer(id: 45, name: "Xplova") }
    /// Perception Digital
    public class var perceptionDigital: Manufacturer { return Manufacturer(id: 46, name: "Perception Digital") }
    /// bf1systems Ltd
    public class var bf1Systems: Manufacturer { return Manufacturer(id: 47, name: "bf1systems Ltd") }
    /// Pioneer
    public class var pioneer: Manufacturer { return Manufacturer(id: 48, name: "Pioneer") }
    /// Spantec
    public class var spantec: Manufacturer { return Manufacturer(id: 49, name: "Spantec") }
    /// Metalogics
    public class var metalogics: Manufacturer { return Manufacturer(id: 50, name: "Metalogics") }
    /// 4IIII Innovations Inc.
    public class var fouriii: Manufacturer { return Manufacturer(id: 51, name: "4IIII Innovations Inc.") }
    /// Seiko Epson
    public class var seikoEpson: Manufacturer { return Manufacturer(id: 52, name: "Seiko Epson") }
    /// Seiko Epson OEM
    public class var seikoEpsonOem: Manufacturer { return Manufacturer(id: 53, name: "Seiko Epson OEM") }
    /// IFor Powell
    public class var iForPowell: Manufacturer { return Manufacturer(id: 54, name: "IFor Powell") }
    /// Maxwell Guider
    public class var maxwellGuider: Manufacturer { return Manufacturer(id: 55, name: "Maxwell Guider") }
    /// Star Trac
    public class var starTrac: Manufacturer { return Manufacturer(id: 56, name: "Star Trac") }
    /// Breakaway
    public class var breakaway: Manufacturer { return Manufacturer(id: 57, name: "Breakaway") }
    /// Alatech Technology LTD.
    public class var alatechTechnology: Manufacturer { return Manufacturer(id: 58, name: "Alatech Technology LTD.") }
    /// MIO Technology Europe
    public class var mioTechnologyEurope: Manufacturer { return Manufacturer(id: 59, name: "MIO Technology Europe") }
    /// Rotor
    public class var rotor: Manufacturer { return Manufacturer(id: 60, name: "Rotor") }
    /// Geonaute
    public class var geonaute: Manufacturer { return Manufacturer(id: 61, name: "Geonaute") }
    /// ID Bike
    public class var idBike: Manufacturer { return Manufacturer(id: 62, name: "ID Bike") }
    /// Specialized
    public class var specialized: Manufacturer { return Manufacturer(id: 63, name: "Specialized") }
    /// WTek
    public class var wTek: Manufacturer { return Manufacturer(id: 64, name: "WTek") }
    /// Physical Enterprises
    public class var physicalEnterprises: Manufacturer { return Manufacturer(id: 65, name: "Physical Enterprises") }
    /// North Pole Engineering
    public class var northPoleEngineering: Manufacturer { return Manufacturer(id: 66, name: "North Pole Engineering") }
    /// BKool
    public class var bKool: Manufacturer { return Manufacturer(id: 67, name: "BKool") }
    /// Cateye
    public class var cateye: Manufacturer { return Manufacturer(id: 68, name: "Cateye") }
    /// Stages Cycling
    public class var stagesCycling: Manufacturer { return Manufacturer(id: 69, name: "Stages Cycling") }
    /// SIGMA SPORT
    public class var sigmaSport: Manufacturer { return Manufacturer(id: 70, name: "SIGMA SPORT") }
    /// Tom Tom
    public class var tomTom: Manufacturer { return Manufacturer(id: 71, name: "Tom Tom") }
    /// Peripedal
    public class var peripedal: Manufacturer { return Manufacturer(id: 72, name: "Peripedal") }
    /// Wattbike
    public class var wattBike: Manufacturer { return Manufacturer(id: 73, name: "Wattbike") }

    //74-75 NOT ASSIGNED

    /// MOXY
    public class var moxy: Manufacturer { return Manufacturer(id: 76, name: "MOXY") }
    /// CicloSport
    public class var cicloSport: Manufacturer { return Manufacturer(id: 77, name: "CicloSport") }
    /// POWERbahn
    public class var powerBahn: Manufacturer { return Manufacturer(id: 78, name: "POWERbahn") }
    /// Acorn Project Aps.
    public class var acornProjectAps: Manufacturer { return Manufacturer(id: 79, name: "Acorn Project Aps.") }
    /// LifeBEAM
    public class var lifeBeam: Manufacturer { return Manufacturer(id: 80, name: "LifeBEAM") }
    /// Bontrager
    public class var bontrager: Manufacturer { return Manufacturer(id: 81, name: "Bontrager") }
    /// Wellgo
    public class var wellgo: Manufacturer { return Manufacturer(id: 82, name: "Wellgo") }
    /// Scosche
    public class var scosche: Manufacturer { return Manufacturer(id: 83, name: "Scosche") }
    /// MAGURA
    public class var magura: Manufacturer { return Manufacturer(id: 84, name: "MAGURA") }
    /// Woodway
    public class var woodway: Manufacturer { return Manufacturer(id: 85, name: "Woodway") }
    /// Elite
    public class var elite: Manufacturer { return Manufacturer(id: 86, name: "Elite") }
    /// Nielsen-Kellerman
    public class var nielsenKellerman: Manufacturer { return Manufacturer(id: 87, name: "Nielsen-Kellerman") }
    /// DK City
    public class var dkCity: Manufacturer { return Manufacturer(id: 88, name: "DK City") }
    /// Tacx
    public class var tacx: Manufacturer { return Manufacturer(id: 89, name: "Tacx") }
    /// Direction Technology
    public class var directionTechnology: Manufacturer { return Manufacturer(id: 90, name: "Direction Technology") }
    /// Magtonic
    public class var magtonic: Manufacturer { return Manufacturer(id: 91, name: "Magtonic") }
    /// 1partCarbon Inc.
    public class var onePartCarbon: Manufacturer { return Manufacturer(id: 92, name: "1partCarbon Inc.") }
    /// Inside Ride
    public class var insideRide: Manufacturer { return Manufacturer(id: 93, name: "Inside Ride") }
    /// Sound Of Motion
    public class var soundOfMotion: Manufacturer { return Manufacturer(id: 94, name: "Sound Of Motion") }
    /// Stryd
    public class var stryd: Manufacturer { return Manufacturer(id: 95, name: "Stryd") }
    /// Indoor Cycling Group
    public class var indoorCyclingGroup: Manufacturer { return Manufacturer(id: 96, name: "Indoor Cycling Group") }
    /// Mi Pulse
    public class var miPulse: Manufacturer { return Manufacturer(id: 97, name: "Mi Pulse") }
    /// BSX Athletics
    public class var bsxAthletics: Manufacturer { return Manufacturer(id: 98, name: "BSX Athletics") }
    /// Look
    public class var look: Manufacturer { return Manufacturer(id: 99, name: "Look") }
    /// Campagnolo Srl
    public class var campagnolo: Manufacturer { return Manufacturer(id: 100, name: "Campagnolo Srl") }
    /// Body Bike Smart
    public class var bodyBikeSmart: Manufacturer { return Manufacturer(id: 101, name: "Body Bike Smart") }
    /// Praxisworks
    public class var praxisworks: Manufacturer { return Manufacturer(id: 102, name: "Praxisworks") }
    /// Limits Technology
    public class var limitsTechnology: Manufacturer { return Manufacturer(id: 103, name: "Limits Technology") }
    /// TopAction Technology
    public class var topActionTechnology: Manufacturer { return Manufacturer(id: 104, name: "TopAction Technology") }
    /// Cosinuss
    public class var cosinuss: Manufacturer { return Manufacturer(id: 105, name: "Cosinuss") }
    /// Fitcare
    public class var fitCare: Manufacturer { return Manufacturer(id: 106, name: "Fitcare") }
    /// Magene
    public class var magene: Manufacturer { return Manufacturer(id: 107, name: "Magene") }
    /// Giant Manufacturing Co
    public class var giantManufacturing: Manufacturer { return Manufacturer(id: 108, name: "Giant Manufacturing Co") }
    /// TiGRA Sport
    public class var tigraSport: Manufacturer { return Manufacturer(id: 109, name: "TiGRA Sport") }
    /// Salutron
    public class var salutron: Manufacturer { return Manufacturer(id: 110, name: "Salutron") }
    /// TechnoGym
    public class var technogym: Manufacturer { return Manufacturer(id: 111, name: "TechnoGym") }
    /// Bryton Sensors
    public class var brytonSensors: Manufacturer { return Manufacturer(id: 112, name: "Bryton Sensors") }
    /// Latitude Limited
    public class var latitudeLimited: Manufacturer { return Manufacturer(id: 113, name: "Latitude Limited") }
    /// Soaring Technology
    public class var soaringTechnology: Manufacturer { return Manufacturer(id: 114, name: "Soaring Technology") }
    /// IGP Sport
    public class var igpSport: Manufacturer { return Manufacturer(id: 115, name: "IGP Sport") }
    /// Think Rider
    public class var thinkRider: Manufacturer { return Manufacturer(id: 116, name: "Think Rider") }
    /// Gopher Sport
    public class var gopherSport: Manufacturer { return Manufacturer(id: 117, name: "Gopher Sport") }
    /// Water Rower
    public class var waterRower: Manufacturer { return Manufacturer(id: 118, name: "Water Rower") }

    //119-254 NOT ASSIGNED
    //256 NOT ASSIGNED

    /// Health and Life
    public class var healthAndLife: Manufacturer { return Manufacturer(id: 257, name: "Health and Life") }
    /// Lezyne
    public class var lezyne: Manufacturer { return Manufacturer(id: 258, name: "Lezyne") }
    /// Scribe Labs
    public class var scribeLabs: Manufacturer { return Manufacturer(id: 259, name: "Scribe Labs") }
    /// Zwift
    public class var zwift: Manufacturer { return Manufacturer(id: 260, name: "Zwift") }
    /// Watteam
    public class var watteam: Manufacturer { return Manufacturer(id: 261, name: "Watteam") }
    /// Recon
    public class var recon: Manufacturer { return Manufacturer(id: 262, name: "Recon") }
    /// Favero Electronics
    public class var faveroElectronics: Manufacturer { return Manufacturer(id: 263, name: "Favero Electronics") }
    /// Dyno Velo
    public class var dynoVelo: Manufacturer { return Manufacturer(id: 264, name: "Dyno Velo") }
    /// Strava
    public class var strava: Manufacturer { return Manufacturer(id: 265, name: "Strava") }
    /// Precor
    public class var precore: Manufacturer { return Manufacturer(id: 266, name: "Precor") }
    /// Bryton
    public class var byrton: Manufacturer { return Manufacturer(id: 267, name: "Bryton") }
    /// SRAM
    public class var sram: Manufacturer { return Manufacturer(id: 268, name: "SRAM") }
    /// Mio Technology
    public class var mioTechnology: Manufacturer { return Manufacturer(id: 269, name: "Mio Technology") }
    /// COBI GmbH
    public class var cobi: Manufacturer { return Manufacturer(id: 270, name: "COBI GmbH") }
    /// Spivi
    public class var spivi: Manufacturer { return Manufacturer(id: 271, name: "Spivi") }
    /// Mio Magellan
    public class var mioMagellan: Manufacturer { return Manufacturer(id: 272, name: "Mio Magellan") }
    /// Evesports
    public class var eveSports: Manufacturer { return Manufacturer(id: 273, name: "Evesports") }
    /// Sensitivus Gauge
    public class var sensitivusGauge: Manufacturer { return Manufacturer(id: 274, name: "Sensitivus Gauge") }
    /// Podoon
    public class var podoon: Manufacturer { return Manufacturer(id: 275, name: "Podoon") }
    /// Life Time Fitness
    public class var lifeTimeFitness: Manufacturer { return Manufacturer(id: 276, name: "Life Time Fitness") }
    /// Falco eMotors Inc.
    public class var falcoEMotors: Manufacturer { return Manufacturer(id: 277, name: "Falco eMotors Inc.") }
    /// Minoura
    public class var minoura: Manufacturer { return Manufacturer(id: 278, name: "Minoura") }
    /// Cycliq
    public class var cycliq: Manufacturer { return Manufacturer(id: 279, name: "Cycliq") }
    /// Luxxottica
    public class var luxottica: Manufacturer { return Manufacturer(id: 280, name: "Luxxottica") }
    /// Trainer Road
    public class var trainerRoad: Manufacturer { return Manufacturer(id: 281, name: "Trainer Road") }
    /// The Sufferfest
    public class var theSufferfest: Manufacturer { return Manufacturer(id: 282, name: "The Sufferfest") }
    /// Full Speed Ahead
    public class var fullSpeedAhead: Manufacturer { return Manufacturer(id: 283, name: "Full Speed Ahead") }
    /// Virtual Training
    public class var virtualTraining: Manufacturer { return Manufacturer(id: 284, name: "Virtual Training") }
    /// Feedback Sports
    public class var feedbackSports: Manufacturer { return Manufacturer(id: 285, name: "Feedback Sports") }
    /// Omata
    public class var omata: Manufacturer { return Manufacturer(id: 286, name: "Omata") }
    /// VDO
    public class var vdo: Manufacturer { return Manufacturer(id: 287, name: "VDO") }


    /// ActiGraph
    public class var actiGraph: Manufacturer { return Manufacturer(id: 5769, name: "ActiGraph") }
}
