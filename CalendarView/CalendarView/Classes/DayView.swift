//
//  DayView.swift
//  Calendar
//
//  Created by Nate Armstrong on 3/28/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

import UIKit
import SwiftMoment

let CalendarSelectedDayNotification = "CalendarSelectedDayNotification"

class DayView: UIView {

  var date: Moment! {
    didSet {
      dateLabel.text = date.format("d")
      setNeedsLayout()
    }
  }
  lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .Center
    label.font = CalendarView.dayFont
    self.addSubview(label)
    return label
  }()
  var isToday: Bool = false
  var isOtherMonth: Bool = false
  var selected: Bool = false {
    didSet {
      if selected {
        NSNotificationCenter.defaultCenter()
          .postNotificationName(CalendarSelectedDayNotification, object: date.toNSDate())
      }
      updateView()
    }
  }

  init() {
    super.init(frame: CGRectZero)
    let tap = UITapGestureRecognizer(target: self, action: "select")
    addGestureRecognizer(tap)
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "onSelected:",
      name: CalendarSelectedDayNotification,
      object: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    dateLabel.frame = CGRectInset(bounds, 10, 10)
    updateView()
  }

  func onSelected(notification: NSNotification) {
    if let date = date, nsDate = notification.object as? NSDate {
      let mo = moment(nsDate)
      if mo.month != date.month || mo.day != date.day {
        selected = false
      }
    }
  }

  func updateView() {
    if self.selected {
      dateLabel.textColor = CalendarView.daySelectedTextColor
      dateLabel.backgroundColor = CalendarView.daySelectedBackgroundColor
    } else if isToday {
      dateLabel.textColor = CalendarView.todayTextColor
      dateLabel.backgroundColor = CalendarView.todayBackgroundColor
    } else if isOtherMonth {
      dateLabel.textColor = CalendarView.otherMonthTextColor
      dateLabel.backgroundColor = CalendarView.otherMonthBackgroundColor
    } else {
      self.dateLabel.textColor = CalendarView.dayTextColor
      self.dateLabel.backgroundColor = CalendarView.dayBackgroundColor
    }
  }

  func select() {
    selected = true
  }

}

public extension Moment {

  func toNSDate() -> NSDate? {
    let epoch = moment(NSDate(timeIntervalSince1970: 0))
    let timeInterval = self.intervalSince(epoch)
    let date = NSDate(timeIntervalSince1970: timeInterval.seconds)
    return date
  }

  func isToday() -> Bool {
    let cal = NSCalendar.currentCalendar()
    return cal.isDateInToday(self.toNSDate()!)
  }

  func isSameMonth(other: Moment) -> Bool {
    return self.month == other.month && self.year == other.year
  }

}
