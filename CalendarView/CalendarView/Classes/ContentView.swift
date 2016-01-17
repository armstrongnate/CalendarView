//
//  CalendarContentView.swift
//  Calendar
//
//  Created by Nate Armstrong on 3/28/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

import UIKit
import SwiftMoment

class ContentView: UIScrollView {

  let numMonthsLoaded = 3
  let currentPage = 1
  var months: [MonthView] = []
  var selectedDate: Moment?
  var paged = false

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  func setup() {
    pagingEnabled = true
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false

    for month in months {
      month.setdown()
      month.removeFromSuperview()
    }

    months = []
    let date = selectedDate ?? moment()
    selectedDate = date
    var currentDate = date.subtract(1, .Months)
    for _ in 1...numMonthsLoaded {
      let month = MonthView(frame: CGRectZero)
      month.date = currentDate
      addSubview(month)
      months.append(month)
      currentDate = currentDate.add(1, .Months)
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    var x: CGFloat = 0
    for month in months {
      month.frame = CGRectMake(x, 0, bounds.size.width, bounds.size.height)
      x = CGRectGetMaxX(month.frame)
    }
    contentSize = CGSizeMake(bounds.size.width * numMonthsLoaded, bounds.size.height)
  }

  func selectPage(page: Int) {
    var page1FrameMatched = false
    var page2FrameMatched = false
    var page3FrameMatched = false
    var frameCurrentMatched = false

    let pageWidth = frame.size.width
    let pageHeight = frame.size.height

    let frameCurrent = CGRectMake(page * pageWidth, 0, pageWidth, pageHeight)
    let frameLeft = CGRectMake((page-1) * pageWidth, 0, pageWidth, pageHeight)
    let frameRight = CGRectMake((page+1) * pageWidth, 0, pageWidth, pageHeight)

    let page1 = months.first!
    let page2 = months[1]
    let page3 = months.last!

    if frameCurrent.origin.x == page1.frame.origin.x {
      page1FrameMatched = true
      frameCurrentMatched = true
    }
    else if frameCurrent.origin.x == page2.frame.origin.x {
      page2FrameMatched = true
      frameCurrentMatched = true
    }
    else if frameCurrent.origin.x == page3.frame.origin.x {
      page3FrameMatched = true
      frameCurrentMatched = true
    }

    if frameCurrentMatched {
      if page2FrameMatched {
        print("something weird happened")
      }
      else if page1FrameMatched {
        page3.date = page1.date.subtract(1, .Months)
        page1.frame = frameCurrent
        page2.frame = frameRight
        page3.frame = frameLeft
        months = [page3, page1, page2]
      }
      else if page3FrameMatched {
        page1.date = page3.date.add(1, .Months)
        page1.frame = frameRight
        page2.frame = frameLeft
        page3.frame = frameCurrent
        months = [page2, page3, page1]
      }
      contentOffset.x = CGRectGetWidth(frame)
      selectedDate = nil
      paged = true
    }
  }

  func selectDate(date: Moment) {
    selectedDate = date
    setup()
    selectVisibleDate(date.day)
    setNeedsLayout()
  }

  func selectVisibleDate(date: Int) -> DayView? {
    let month = currentMonth()
    for week in month.weeks {
      for day in week.days {
        if day.date != nil && day.date.month == month.date.month && day.date.day == date {
          day.selected = true
          return day
        }
      }
    }
    return nil
  }

  func removeObservers() {
    for month in months {
      for week in month.weeks {
        for day in week.days {
          NSNotificationCenter.defaultCenter().removeObserver(day)
        }
      }
    }
  }

  func currentMonth() -> MonthView {
    return months[1]
  }

}
