//
//  CalendarView.swift
//  Calendar
//
//  Created by Nate Armstrong on 3/27/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

import UIKit
import SwiftMoment

public protocol CalendarViewDelegate {
  func calendarDidSelectDate(date: Moment)
  func calendarDidPageToDate(date: Moment)
}

public class CalendarView: UIView {

  private struct Appearance {
    static var dayBackgroundColor = UIColor.clearColor()
    static var daySelectedBackgroundColor = UIColor.orangeColor()
    static var todayBackgroundColor = UIColor.lightGrayColor()
    static var todayTextColor = UIColor.blackColor()
    static var dayTextColor = UIColor.blackColor()
    static var daySelectedTextColor = UIColor.whiteColor()
    static var otherMonthTextColor = UIColor.lightGrayColor()
    static var otherMonthBackgroundColor = UIColor.clearColor()
    static var weekLabelTextColor = UIColor.blackColor()
    static var dayFont = UIFont.systemFontOfSize(15)
  }

  public class var dayBackgroundColor: UIColor {
    get { return Appearance.dayBackgroundColor }
    set { Appearance.dayBackgroundColor = newValue }
  }
  public class var daySelectedBackgroundColor: UIColor {
    get { return Appearance.daySelectedBackgroundColor }
    set { Appearance.daySelectedBackgroundColor = newValue }
  }
  public class var todayBackgroundColor: UIColor {
    get { return Appearance.todayBackgroundColor }
    set { Appearance.todayBackgroundColor = newValue }
  }
  public class var todayTextColor: UIColor {
    get { return Appearance.todayTextColor }
    set { Appearance.todayTextColor = newValue }
  }
  public class var dayTextColor: UIColor {
    get { return Appearance.dayTextColor }
    set { Appearance.dayTextColor = newValue }
  }
  public class var daySelectedTextColor: UIColor {
    get { return Appearance.daySelectedTextColor }
    set { Appearance.daySelectedTextColor = newValue }
  }
  public class var otherMonthTextColor: UIColor {
    get { return Appearance.otherMonthTextColor }
    set { Appearance.otherMonthTextColor = newValue }
  }
  public class var otherMonthBackgroundColor: UIColor {
    get { return Appearance.otherMonthBackgroundColor }
    set { Appearance.otherMonthBackgroundColor = newValue }
  }
  public class var weekLabelTextColor: UIColor {
    get { return Appearance.weekLabelTextColor }
    set { Appearance.weekLabelTextColor = newValue }
  }
  public class var dayFont: UIFont {
    get { return Appearance.dayFont }
    set { Appearance.dayFont = newValue }
  }

  lazy var contentView: ContentView = {
    let cv = ContentView(frame: CGRectZero)
    cv.delegate = self
    self.addSubview(cv)
    return cv
  }()
  public var delegate: CalendarViewDelegate? {
    didSet {
      delegate?.calendarDidPageToDate(contentView.currentMonth().date)
    }
  }
  public var selectedDayOnPaged: Int? = 1

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public init() {
    super.init(frame: CGRectZero)
    setup()
  }

  override public func willMoveToWindow(newWindow: UIWindow?) {
    if newWindow == nil {
      NSNotificationCenter.defaultCenter().removeObserver(self)
      contentView.removeObservers()
    } else {
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "dateSelected:", name: CalendarSelectedDayNotification, object: nil)
    }
  }

  func setup() {
    if let date = contentView.selectedDate {
      contentView.selectVisibleDate(date.day)
      delegate?.calendarDidSelectDate(moment(date))
      contentView.selectedDate = nil
    }
  }

  override public func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = bounds
    contentView.contentOffset.x = CGRectGetWidth(contentView.frame)
  }

  func dateSelected(notification: NSNotification) {
    if let date = notification.object as? NSDate {
      delegate?.calendarDidSelectDate(moment(date))
    }
  }

  public func selectDate(date: Moment) {
    contentView.selectDate(date)
  }

}

extension CalendarView: UIScrollViewDelegate {

  public func scrollViewDidScroll(scrollView: UIScrollView) {
    contentView.paged = false
    let ratio = contentView.contentOffset.x / CGRectGetWidth(contentView.frame)
    if ratio.isNaN { return }
    if ratio >= 2.0 || ratio <= 0.0 {
      contentView.selectPage(Int(ratio))
    }
  }

  public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    contentView.setContentOffset(CGPointMake(CGRectGetWidth(contentView.frame), contentView.contentOffset.y), animated: true)
    delegate?.calendarDidPageToDate(contentView.currentMonth().date)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
      if let day = self.selectedDayOnPaged {
        let dayView = self.contentView.selectVisibleDate(day)
        dispatch_async(dispatch_get_main_queue()) {
          if let view = dayView {
            view.selected = true
          }
        }
      }
    }
  }

}
