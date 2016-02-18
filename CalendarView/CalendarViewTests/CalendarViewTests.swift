//
//  CalendarViewTests.swift
//  CalendarViewTests
//
//  Created by Nate Armstrong on 10/12/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import XCTest
@testable import CalendarView
import SwiftMoment

class CalendarViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNovember2015Bug() {
        let october = moment("10-12-2015")!
        XCTAssertEqual("October 12, 2015", october.format("MMMM d, yyyy"))
        let november = october.add(1, .Months)
        let date = november.startOf(.Months)
        XCTAssertEqual(1, date.day)
        let date2 = date.endOf(.Days).add(1, .Days)
        XCTAssertEqual(2, date2.day)
    }

    // See: https://github.com/n8armstrong/CalendarView/issues/7
    func testSecondSundayInMarchBug() {
        let marchFirst = moment("3-1-2016")!
        let firstVisibleDay = marchFirst.startOf(.Months).endOf(.Days).subtract(marchFirst.weekday - 1, .Days).startOf(.Days)
        XCTAssertEqual("February 28, 2016", firstVisibleDay.format("MMMM d, yyyy"))
        let dayInQuestion = firstVisibleDay.add(14, .Days)
        XCTAssertEqual(13, dayInQuestion.day)
    }

}
