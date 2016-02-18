//
//  MonthView.swift
//  Calendar
//
//  Created by Nate Armstrong on 3/28/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

import UIKit
import SwiftMoment

class MonthView: UIView {

  let maxNumWeeks = 6

  var date: Moment! {
    didSet {
      startsOn = date.startOf(.Months).weekday // Sun is 1
      let numDays = Double(date.endOf(.Months).day + startsOn - 1)
      self.numDays = Int(ceil(numDays / 7.0) * 7)
      self.numDays = 42 // TODO: add option to always show 6 weeks
      setWeeks()
    }
  }

  var weeks: [WeekView] = []
  var weekLabels: [WeekLabel] = [
    WeekLabel(day: "SUN"),
    WeekLabel(day: "MON"),
    WeekLabel(day: "TUE"),
    WeekLabel(day: "WED"),
    WeekLabel(day: "THU"),
    WeekLabel(day: "FRI"),
    WeekLabel(day: "SAT"),
  ]

  // these values are expensive to compute so cache them
  var numDays: Int = 30
  var startsOn: Int = 0

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  func setup() {
    weeks = []
    for _ in 1...maxNumWeeks {
      let week = WeekView(frame: CGRectZero)
      addSubview(week)
      weeks.append(week)
    }
    for label in weekLabels {
      addSubview(label)
    }
  }

  func setdown() {
    for week in weeks {
      week.setdown()
      week.removeFromSuperview()
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    var x: CGFloat = 0
    let labelHeight: CGFloat = 18
    let inset: CGFloat = 10
    for label in weekLabels {
      label.frame = CGRectMake(x, inset, bounds.size.width / 7, labelHeight)
      x = CGRectGetMaxX(label.frame)
    }
    var y: CGFloat = labelHeight + inset
    for i in 1...weeks.count {
      let week = weeks[i - 1]
      week.frame = CGRectMake(0, y, bounds.size.width, (bounds.size.height - (labelHeight + inset) - inset) / maxNumWeeks)
      y = CGRectGetMaxY(week.frame)
    }
  }

  func setWeeks() {
    if weeks.count > 0 {
      let numWeeks = Int(numDays / 7)
      let firstVisibleDate  = date.startOf(.Months).endOf(.Days).subtract(startsOn - 1, .Days).startOf(.Days)
      for i in 1...weeks.count {
        let firstDateOfWeek = firstVisibleDate.add(7*(i-1), .Days)
        let week = weeks[i - 1]
        week.month = date
        week.date = firstDateOfWeek
        week.hidden = i > numWeeks
      }
    }
  }

}

class WeekLabel: UILabel {

  init(day: String) {
    super.init(frame: CGRectZero)
    text = day
    textAlignment = .Center
    textColor = CalendarView.weekLabelTextColor
    font = UIFont.boldSystemFontOfSize(10)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

}
