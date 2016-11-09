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
    label.textAlignment = .center
    label.font = CalendarView.dayFont
    self.addSubview(label)
    return label
  }()
  var isToday: Bool = false
  var isOtherMonth: Bool = false
  var selected: Bool = false {
    didSet {
      if selected {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: CalendarSelectedDayNotification), object: date.toDate())
      }
      updateView()
    }
  }

  init() {
    super.init(frame: CGRect.zero)
    let tap = UITapGestureRecognizer(target: self, action: #selector(DayView.select as (DayView) -> () -> ()))
    addGestureRecognizer(tap)
    NotificationCenter.default.addObserver(self,
      selector: #selector(DayView.onSelected(_:)),
      name: NSNotification.Name(rawValue: CalendarSelectedDayNotification),
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
    dateLabel.frame = bounds.insetBy(dx: 10, dy: 10)
    updateView()
  }

  func onSelected(_ notification: Notification) {
    if let date = date, let nsDate = notification.object as? Date {
      let mo = moment(nsDate)
      if mo.month != date.month || mo.day != date.day {
        selected = false
      }
    }
  }

  func updateView() {
    if self.selected {
      self.dateLabel.textColor = CalendarView.daySelectedTextColor
      self.dateLabel.backgroundColor = CalendarView.daySelectedBackgroundColor
    } else if self.isToday {
      self.dateLabel.textColor = CalendarView.todayTextColor
      self.dateLabel.backgroundColor = CalendarView.todayBackgroundColor
    } else if self.isOtherMonth {
      self.dateLabel.textColor = CalendarView.otherMonthTextColor
      self.dateLabel.backgroundColor = CalendarView.otherMonthBackgroundColor
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

  func toDate() -> Date? {
    let epoch = moment(Date(timeIntervalSince1970: 0))
    let timeInterval = self.intervalSince(epoch)
    let date = Date(timeIntervalSince1970: timeInterval.seconds)
    return date
  }

  func isToday() -> Bool {
    let cal = NSCalendar.current
    return cal.isDateInToday(self.toDate()!)
  }

  func isSameMonth(_ other: Moment) -> Bool {
    return self.month == other.month && self.year == other.year
  }

}
