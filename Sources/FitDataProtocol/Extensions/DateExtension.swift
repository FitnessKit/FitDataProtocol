//
//  DateExtension.swift
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

internal extension Date {

    /**
     Creates a Date from a given year, month, day

     - parameter year: Int value of Year
     - parameter month: Int value of Month
     - parameter day: Int value of the Day

     - returns: an Date object with the given
     */
    init(year: Int, month: Int, day: Int) {
        var c = DateComponents()
        c.year = year
        c.month = month
        c.day = day

        let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)

        let date = gregorian.date(from: c)
        self.init(timeInterval: 0, since: date!)
    }

    /// ANT+ EPOCH
    static var antEPOCH: Date {
        var comps = DateComponents(year: 1989,
                                   month: 12,
                                   day: 31)
        comps.timeZone = TimeZone(secondsFromGMT: 0)

        return Calendar(identifier: .gregorian).date(from: comps)!
    }

    /// Localized ANT+ EPOCH
    static var localAntEPOCH: Date {
        var comps = DateComponents(year: 1989,
                                   month: 12,
                                   day: 31)
        comps.timeZone = TimeZone.current

        return Calendar(identifier: .gregorian).date(from: comps)!
    }

}
