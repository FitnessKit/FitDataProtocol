//
//  GarminProduct.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/27/19.
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

/// FIT Garmin Product Ids
public enum GarminProduct: UInt16 {
    /// HRM1
    case hrm1                   = 1
    /// AXH01 HRM chipset
    case axho1Hrm               = 2
    /// AXB01
    case axb01                  = 3
    /// AXB02
    case axb02                  = 4
    /// HRM2SS
    case hrm2SS                 = 5
    /// DSI_ALF02
    case dsiAlf02               = 6
    /// HRM3SS
    case hrm3SS                 = 7
    /// hrm_run model for HRM ANT+ messaging
    case hrmRunSingleByte       = 8
    /// BSM model for ANT+ messaging
    case bsm                    = 9
    /// BCM model for ANT+ messaging
    case bcm                    = 10
    /// AXS01 HRM Bike Chipset model for ANT+ messaging
    case axs01hrmBike           = 11
    /// hrm_tri model for HRM ANT+ messaging
    case hrmTriAnt              = 12
    /// fr225 model for HRM ANT+ messaging
    case forerunner255Hrm       = 14
    /// FR301 China
    case forerunner301China     = 473
    /// FR301 Japan
    case forerunner301Japan     = 474
    /// FR301 Korea
    case forerunner301Korea     = 475
    /// FR301 Taiwan
    case forerunner301Taiwan    = 494
    /// Forerunner 405
    case forerunner405          = 717
    /// Forerunner 50
    case forerunner50           = 782
    /// Forerunner 405 Japan
    case forerunner405Japan     = 987
    /// Forerunner 60
    case forerunner60           = 988
    /// DSI ALF01
    case dsiAlf01               = 1011
    /// Forerunner 310
    case forerunner310Xt        = 1018
    /// Edge 500
    case edge500                = 1036
    /// Forerunner 110
    case forerunner110          = 1124
    /// Edge 800
    case edge800                = 1169
    /// Edge 500 Taiwan
    case edge500Taiwan          = 1199
    /// Edge 500 Japan
    case edge500Japan           = 1213
    /// Chirp
    case chirp                  = 1153
    /// Forerunner 110 Japan
    case forerunner110Japan     = 1274
    /// Edge 200
    case edge200                = 1325
    /// Forerunner 10 XT
    case forerunner10Xt         = 1328
    /// Edge 800 Taiwan
    case edge800Taiwan          = 1333
    /// Edge 800 Japan
    case edge800Japan           = 1334
    /// ALF04
    case alf04                  = 1341
    /// Forerunner 610
    case forerunner610          = 1345
    /// Forerunner 210 Japan
    case forerunner210Japan     = 1360
    /// Vector SS
    case vectorSs               = 1380
    /// Vector CP
    case vectorCp               = 1381
    /// Edge 800 China
    case edge800China           = 1386
    /// Edge 500 China
    case edge500China           = 1387
    /// Forerunner 610 Japan
    case forerunner610Japan     = 1410
    /// Edge 500 Korea
    case edge500Korea           = 1422
    /// Forerunner 70
    case forerunner70           = 1436
    /// Forerunner 310 XT 4T
    case forerunner310Xt4T      = 1446
    /// AMX
    case amx                    = 1461
    /// Forerunner 10
    case forerunner10           = 1482
    /// Edge 800 Korea
    case edge800Korea           = 1497
    /// Swim
    case swim                   = 1499
    /// Forerunner 910 XT China
    case forerunner910XtChina   = 1537
    /// Fenix
    case fenix                  = 1551
    /// Edge 200 Taiwan
    case edge200Taiwan          = 1555
    /// Edge 510
    case edge510                = 1561
    /// Edge 810
    case edge810                = 1567
    /// Tempe
    case tempe                  = 1570
    /// Forerunner 910 XT Japan
    case forerunner910XtJapan   = 1600
    /// Forerunner 620
    case forerunner620          = 1623
    /// Forerunner 220
    case forerunner220          = 1632
    /// Forerunner 910 XT Korea
    case forerunner910XtKorea   = 1664
    /// Forerunner 10 Japan
    case forerunner10Japan      = 1688
    /// Edge 810 Japan
    case edge810Japan           = 1721
    /// VIRB Elite
    case virbElite              = 1735
    /// Edge Touring
    ///
    /// Also Edge Touring Plus
    case edgeTouring            = 1736
    /// Edge 510 Japan
    case edge510Japan           = 1742
    /// HRM Tri
    case hrmTri                 = 1743
    /// HRM Run
    case hrmRun                 = 1752
    /// Forerunner 920 Xt
    case forerunner920Xt        = 1765
    /// Edge 510 Asia
    case edge510Asia            = 1821
    /// Edge 810 China
    case edge810China           = 1822
    /// Edge 810 Taiwan
    case edge810Taiwan          = 1823
    /// Edge 1000
    case edge1000               = 1836
    /// VIVO Fit
    case vivoFit                = 1837
    /// VIVO Remote
    case vivoRemote             = 1853
    /// VIVO KI
    case vivoKi                 = 1885
    /// Forerunner 15
    case forerunner15           = 1903
    /// VIVO Active
    case vivoActive             = 1907
    /// Edge 510 Korea
    case edge510Korea           = 1918
    /// Forerunner 620 Japan
    case forerunner620Japan     = 1928
    /// Forerunner 620 China
    case forerunner620China     = 1929
    /// Forerunner 220 Japan
    case forerunner220Japan     = 1930
    /// Forerunner 220 China
    case forerunner220China     = 1931
    /// Approach S6
    case approachS6             = 1936
    /// VIVO Smart
    case vivoSmart              = 1956
    /// Fenix 2
    case fenix2                 = 1967
    /// Epix
    case epix                   = 1988
    /// Fenix 3
    case fenix3                 = 2050
    /// Edge 1000 Taiwan
    case edge1000Taiwan         = 2052
    /// Edge 1000 Japan
    case edge1000Japan          = 2053
    /// Forerunner 15 Japan
    case forerunner15Japan      = 2061
    /// Edge 520
    case edge520                = 2067
    /// Edge 1000 China
    case edge1000China          = 2070
    /// Forerunner 620 Russia
    case forerunner620Russia    = 2072
    /// Forerunner 220 Russia
    case forerunner220Russia    = 2073
    /// Vector S
    case vectorS                = 2079
    /// Edge 1000 Korea
    case edge1000Korea          = 2100
    /// Forerunner 920 XT Taiwan
    case forerunner920XtTaiwan  = 2130
    /// Forerunner 920 XT China
    case forerunner920XtChina   = 2131
    /// Forerunner 920 XT Japan
    case forerunner920XtJapan   = 2132
    /// VIRB X
    case virbX                  = 2134
    /// VIVO Smart APAC
    case vivoSmartApac          = 2135
    /// ETREX Touch
    case etrexTouch             = 2140
    /// EDGE 25
    case edge25                 = 2147
    /// Forerunner 25
    case forerunner25           = 2148
    /// VIVO Fit 2
    case vivoFit2               = 2150
    /// Forerunner 225
    case forerunner225          = 2153
    /// Forerunner 630
    case forerunner630          = 2156
    /// Forerunner 230
    case forerunner230          = 2157
    /// VIVO Active APAC
    case vivoActiveApac         = 2160
    /// Vector 2
    case vector2                = 2161
    /// Vector 2S
    case vector2s               = 2162
    /// VIRB XE
    case virbeXe                = 2172
    /// Forerunner 620 Taiwan
    case forerunner620Taiwan    = 2173
    /// Forerunner 220 Taiwan
    case forerunner220Taiwan    = 2174
    /// TruSwing
    case truSwing               = 2175
    /// Fenix 3 China
    case fenix3China            = 2188
    /// Fenix 3 Taiwan
    case fenix3Taiwan           = 2189
    /// Varia Headlight
    case variaHeadlight         = 2192
    /// Varia Taillight
    case variaTailight          = 2193
    /// EDGE Explore 1000
    case edgeExplore1000        = 2204
    /// Forerunner 225 Asia
    case forerunner225Asia      = 2219
    /// Varia Radar Taillight
    case variaRadarTaillight    = 2225
    /// Varia Radar Display
    case variaRadarDisplay      = 2226
    /// EDGE 20
    case edge20                 = 2238
    /// D2 Bravo
    case d2Bravo                = 2262
    /// Appraoch S20
    case approachS20            = 2266
    /// Varia Remote
    case variaRemote            = 2276
    /// HRM4 Run
    case hrm4Run                = 2327
    /// VIVO Active HR
    case vivoActiveHr           = 2337
    /// Vivo Smart GPS HR
    case vivoSmartGpsHr         = 2347
    /// Vivo Smart HR
    case vivoSmartHr            = 2348
    /// Vivo Move
    case vivoMove               = 2368
    /// Varia Vision
    case variaVison             = 2398
    /// Vivo Fit 3
    case vivoFit3               = 2406
    /// Fenix 3 HR
    case fenix3Hr               = 2413
    /// VIRB Ultra 30
    case virbUltra30            = 2417
    /// Index Smart Cycle
    case indexSmartCycle        = 2429
    /// Forerunner 235
    case forerunner235          = 2431
    /// Fenix 3 Chronos
    case fenix3Chronos          = 2432
    /// Oregon 7XX
    case oregon7xx              = 2441
    /// Rino 7XX
    case rino7xx                = 2444
    /// Nautix
    case nautix                 = 2496
    /// EDGE 820
    case edge820                = 2530
    /// EDGE Explore 820
    case edgeExplore820         = 2531
    /// Fenix 5s
    case fenix5s                = 2544
    /// D2 Bravo Titanium
    case d2BravoTitanium        = 2547
    /// Varia UT 800 SW
    case variaUt800             = 2567
    /// Running Dynamics Pod
    case runningDynamicsPod     = 2593
    /// Fenix 5X
    case fenix5x                = 2604
    /// Vivo Fit Jr.
    case vivoFitJr              = 2606
    /// Vivo Smart3
    case vivoSmart3             = 2622
    /// Vivo Sport
    case vivoSport              = 2623
    /// Approach S60
    case approachS60            = 2656
    /// Virb 360
    case virb360                = 2687
    /// Forerunner 930
    case forerunner935          = 2691
    /// Fenix X5
    case fenixX5                = 2697
    /// Vivo Active 3
    case vivoActive3            = 2700
    /// ForeTrex 601-701
    case foreTrex               = 2769
    /// Vivo Move HR
    case vivoMoveHr             = 2772
    /// Edge 1030
    case edge1030               = 2713
    /// Approach Z80
    case approachZ80            = 2806
    /// Vivo Smart 3 APAC
    case vivoSmart3Apac         = 2831
    /// Vivo Sport APAC
    case vivoSportApac          = 2832
    /// Descent
    case descent                = 2859
    /// Forerunner 645
    case forerunner645          = 2886
    /// Forerunner 645M
    case forerunner645m         = 2888
    /// Fenix 53 Plus
    case fenix5sPlus            = 2900
    /// Edge 130
    case edge130                = 2909
    /// Vivo Smart 4
    case vivoSmart4             = 2927
    /// Approach X10
    case approachX10            = 2962
    /// Vivo Active 3M W
    case vivoActive3mw          = 2988
    /// Edge Explore
    case edgeExplore            = 3011
    /// GPS Map 66
    case gspMap66               = 3028
    /// Approach S10
    case approachS10            = 3049
    /// Vivo Active 3M L
    case vivoActive3ml          = 3066
    /// Approach G80
    case approachG80            = 3085
    /// Fenix 5 Plus
    case fenix5Plus             = 3110
    /// Fenix 5X Plus
    case fenix5xPlus            = 3111
    /// Edge 520 Plus
    case edge520Plus            = 3112
    /// HRM Dual
    case hrmDual                = 3299
    /// Approach S40
    case approachS40            = 3314
    /// Forerunner 245M Asia
    case forerunner245MAsia     = 3321
    /// Edge 530 Apac
    case edge530Apac            = 3349
    /// Edge 830 Apac
    case edge830Apac            = 3350
    /// Vivo Move 3
    case vivoMove3              = 3378
    /// Vivo Active 4 - Small Asia
    case vivoActive4SmallAsia   = 3387
    /// Vivo Active 4 - Large Asia
    case vivoActive4LargeAsia   = 3388
    /// Vivo Active 4 - Oled Asia
    case vivoActive4OledAsia    = 3389
    /// Swim 2
    case swim2                  = 3405
    /// MARQ Driver Asia
    case marqDriverAsia         = 3420
    /// MARQ Aviator Asia
    case marqAviatorAsia        = 3421
    /// Vivo Move 3 Asia
    case vivoMove3Asia          = 3422
    /// Forerunner 945 Asia
    case forerunner945Asia      = 3441
    /// Vivo Active 3T China
    case vivoActive3TChina      = 3446
    /// MARQ Captian Asia
    case marqCaptianAsia        = 3448
    /// MARQ Commander Asia
    case marqCommanderAsia      = 3449
    /// MARQ Expedition Asia
    case marqExpeditionAsia     = 3450
    /// MARQ Athlete Asia
    case marqAthleteAsia        = 3451
    /// Instinct Solar
    case instinctSolar          = 3466
    /// Forerunner 45 Asia
    case forerunner45Asia       = 3469
    /// Vivo Active 3 Daimler
    case vivoActive3Daimler     = 3473
    /// Legecy Rey
    case legecyRey              = 3498
    /// Legecy Darth Vader
    case legecyDarthVader       = 3499
    /// Legecy Captain Marvel
    case legecyCaptainMarvel    = 3500
    /// Legecy First Avenger
    case legecyFirstAvenger     = 3501
    /// Fenix 6S Sport Asia
    case fenix6sSportAsia       = 3512
    /// Fenix 6S Asia
    case fenix6SAsia            = 3513
    /// Fenix 6 Sport Asia
    case fenix6SportAsia        = 3514
    /// Fenix 6 Asia
    case fenix6Asia             = 3515
    /// Fenix 6X Asia
    case fenix6XAsia            = 3516
    /// Legecy Captain Marvel Asia
    case legecyCaptainMarvelAsia = 3535
    /// Legecy First Avenger Asia
    case legecyFirstAvengerAsia = 3536
    /// Legecy Rey Asia
    case legecyReyAsia          = 3537
    /// Legecy Darth Vader Asia
    case legecyDarthVaderAsia   = 3538
    /// Descent MK 2S
    case descentMk2s            = 3542
    /// Edge 130 Plus
    case edge130Plus            = 3558
    /// Edge 1030 Plus
    case edge1030Plus           = 3570
    /// Rally 100/200 Power Meter
    case rally200               = 3578
    /// Forerunner 745
    case forerunner745          = 3589
    /// Venu Sq
    case venuSq                 = 3600
    /// Lily
    case lily                   = 3615
    /// MARQ Adventurer
    case marqAdventurer         = 3624
    /// Enduro
    case enduro                 = 3638
    /// Swim 2 APAC
    case swim2Apac              = 3639
    /// MARQ Adventurer Asia
    case marqAdventurerAsia     = 3648
    /// Forerunner 945 LTE
    case forerunner945Lte       = 3652
    /// Edge 540
    case edge540                = 4061
    /// Edge 840
    case edge840                = 4062
    /// Edge Explore 2
    case edgeExplore2           = 4169
    /// Approach S70
    case approachS70            = 4233
    /// Forerunner 265 Large
    case forerunner265Large     = 4257
    /// Forerunner 265 Small
    case forerunner265Small     = 4258
    /// Tacx Neo Smart
    case tacxNeoSmart           = 4265
    /// Tacx Neo 2 Smart
    case tacxNeo2Smart          = 4266
    /// Tacx Neo 2T Smart
    case tacxNeo2TSmart         = 4267
    /// Tacx Neo Smart Bike
    case tacxNeoSmartBike       = 4268
    /// Tacx Satori Smart
    case tacxSatoriSmart        = 4269
    /// Tacx Flow Smart
    case tacxFlowSmart          = 4270
    /// Tacx Vortex Smart
    case tacxVortexSmart        = 4271
    /// Tacx Bushido Smart
    case tacxBushidoSmart       = 4272
    /// Tacx Flux/Flux S Smart
    case tacxFluxSmart          = 4274
    /// Tacx Flux 2 Smart
    case tacxFlux2Smart         = 4275
    /// Tacx Magnum
    case taxcMagnum             = 4276
    /// Edge 1040 Asia
    case edge1040Asia           = 4305
    /// Epix Gen 2 Pro 42
    case epixGen2Pro42          = 4312
    /// Epix Gen 2 Pro 47
    case epixGen2Pro47          = 4313
    /// Epix Gen 2 Pro 51
    case epixGen2Pro51          = 4314
    /// FR 965
    case forerunner965          = 4315
    /// Enduro 2
    case enduro2                = 4341
    /// Fenix 7 Pro Solar
    case fenix7ProSolar         = 4375
    /// Instinct 2X
    case instinct2X             = 4394
    /// Descent T2
    case descentT2              = 4442
    /// SDM4 Footpod
    case sdm4Footpod            = 10007
    /// EDGE Remote
    case edgeRemote             = 10014
    /// Tacx Training App Windows
    case tacxTrainingWindows    = 20533
    /// Tacx Training App Mac
    case tacxTrainingMac        = 20534
    /// Tacx Training App Mac Catalyst
    case tacxTrainingMacCat     = 20565
    /// Training Center
    case trainingCenter         = 20119
    /// Tacx Training App Android
    case tacxTrainingAndroid    = 30045
    /// Tacx Training App iOS
    case tacxTrainingiOS        = 30046
    /// Tacx Training App Legecy
    case ttacxTrainingLegecy    = 30047
    /// Connect IQ Simulator
    case connectIqSimulator     = 65531
    /// Android ANT+ Plugin
    case androidAntPlusPlugin   = 65532
    /// Garmin Connect Website
    case garminConnect          = 65534

    /// Invalid
    case invalid                = 65535
}
