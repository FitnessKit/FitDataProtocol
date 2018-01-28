//
//  DateExtension.swift
//  FitDataProtocol
//
//  Created by Kevin Hoogheem on 1/20/18.
//

import Foundation

extension Date {

    /**
     Creates a Date from a given year, month, day

     - parameter year: Int value of Year
     - parameter month: Int value of Month
     - parameter day: Int value of the Day

     - returns: an Date object with the given
     */
    init(year:Int, month:Int, day:Int) {
        var c = DateComponents()
        c.year = year
        c.month = month
        c.day = day

        let gregorian = NSCalendar(identifier:NSCalendar.Identifier.gregorian)!

        let date = gregorian.date(from: c)
        self.init(timeInterval:0, since:date!)
    }

    /// ANT+ EPOCH
    public static var antEPOCH: Date {
        var comps = DateComponents(year: 1989,
                                   month: 12,
                                   day: 31)
        comps.timeZone = TimeZone(abbreviation: "UTC")

        return Calendar(identifier: .gregorian).date(from: comps)!
    }

    public static var localAntEPOCH: Date {
        var comps = DateComponents(year: 1989,
                                   month: 12,
                                   day: 31)
        comps.timeZone = TimeZone.current

        return Calendar(identifier: .gregorian).date(from: comps)!
    }

}
