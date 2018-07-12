//
//  WeekView.swift
//  Calendar
//
//  Created by Nate Armstrong on 3/29/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//  Updated to Swift 4 by A&D Progress aka verebes (c) 2018
//

import UIKit
import SwiftMoment

class WeekView: UIView {

  var date: Moment! {
    didSet {
      setDays()
    }
  }
  var days: [DayView] = []
  var month: Moment!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  func setup() {
    days = []
    for _ in 1...7 {
      let day = DayView()
      addSubview(day)
      days.append(day)
    }
  }

  func setdown() {
    for day in days {
        NotificationCenter.default.removeObserver(day)
      day.removeFromSuperview()
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    var x: CGFloat = 0
    for i in 1...days.count {
      let day = days[i - 1]
        day.frame = CGRect(x: x, y: 0, width: bounds.size.width / days.count, height: bounds.size.height)
      x = day.frame.maxX
    }
  }

  func setDays() {
    if days.count > 0 {
      for i in 0..<days.count {
        let day = days[i]
        let dayDate = date.add(i, .Days)
        day.isToday = dayDate.isToday()
        day.isOtherMonth = !month.isSameMonth(other: dayDate)
        day.selected = false
        day.date = dayDate
      }
    }
  }

}
