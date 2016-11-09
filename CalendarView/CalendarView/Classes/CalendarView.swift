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
    func calendarDidSelectDate(_ date: Moment)
    func calendarDidPageToDate(_ date: Moment)
}

open class CalendarView: UIView {
    
    fileprivate struct Appearance {
        static var dayBackgroundColor = UIColor.clear
        static var daySelectedBackgroundColor = UIColor.orange
        static var todayBackgroundColor = UIColor.lightGray
        static var todayTextColor = UIColor.black
        static var dayTextColor = UIColor.black
        static var daySelectedTextColor = UIColor.white
        static var otherMonthTextColor = UIColor.lightGray
        static var otherMonthBackgroundColor = UIColor.clear
        static var weekLabelTextColor = UIColor.black
        static var dayFont = UIFont.systemFont(ofSize: 15)
    }
    
    open class var dayBackgroundColor: UIColor {
        get { return Appearance.dayBackgroundColor }
        set { Appearance.dayBackgroundColor = newValue }
    }
    open class var daySelectedBackgroundColor: UIColor {
        get { return Appearance.daySelectedBackgroundColor }
        set { Appearance.daySelectedBackgroundColor = newValue }
    }
    open class var todayBackgroundColor: UIColor {
        get { return Appearance.todayBackgroundColor }
        set { Appearance.todayBackgroundColor = newValue }
    }
    open class var todayTextColor: UIColor {
        get { return Appearance.todayTextColor }
        set { Appearance.todayTextColor = newValue }
    }
    open class var dayTextColor: UIColor {
        get { return Appearance.dayTextColor }
        set { Appearance.dayTextColor = newValue }
    }
    open class var daySelectedTextColor: UIColor {
        get { return Appearance.daySelectedTextColor }
        set { Appearance.daySelectedTextColor = newValue }
    }
    open class var otherMonthTextColor: UIColor {
        get { return Appearance.otherMonthTextColor }
        set { Appearance.otherMonthTextColor = newValue }
    }
    open class var otherMonthBackgroundColor: UIColor {
        get { return Appearance.otherMonthBackgroundColor }
        set { Appearance.otherMonthBackgroundColor = newValue }
    }
    open class var weekLabelTextColor: UIColor {
        get { return Appearance.weekLabelTextColor }
        set { Appearance.weekLabelTextColor = newValue }
    }
    open class var dayFont: UIFont {
        get { return Appearance.dayFont }
        set { Appearance.dayFont = newValue }
    }
    
    lazy var contentView: ContentView = {
        let cv = ContentView(frame: CGRect.zero)
        cv.delegate = self
        self.addSubview(cv)
        return cv
    }()
    open var delegate: CalendarViewDelegate? {
        didSet {
            delegate?.calendarDidPageToDate(contentView.currentMonth().date)
        }
    }
    open var selectedDayOnPaged: Int? = 1
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    override open func willMove(toWindow newWindow: UIWindow?) {
        if newWindow == nil {
            NotificationCenter.default.removeObserver(self)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(CalendarView.dateSelected(_:)), name: NSNotification.Name(rawValue: CalendarSelectedDayNotification), object: nil)
        }
    }
    
    func setup() {
        if let date = contentView.selectedDate {
            _ = contentView.selectVisibleDate(date.day)
            delegate?.calendarDidSelectDate(moment(date))
            contentView.selectedDate = nil
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
        contentView.contentOffset.x = contentView.frame.width
    }
    
    func dateSelected(_ notification: Notification) {
        guard let date = notification.object as? Date else { return }
        delegate?.calendarDidSelectDate(moment(date))
    }
    
    open func selectDate(_ date: Moment) {
        contentView.selectDate(date)
    }
    
}

extension CalendarView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentView.paged = false
        let ratio = contentView.contentOffset.x / contentView.frame.width
        if ratio.isNaN { return }
        if ratio >= 2.0 || ratio <= 0.0 {
            contentView.selectPage(Int(ratio))
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentView.setContentOffset(CGPoint(x: contentView.frame.width, y: contentView.contentOffset.y), animated: true)
        delegate?.calendarDidPageToDate(contentView.currentMonth().date)
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.high).async {
            guard let day = self.selectedDayOnPaged else { return }
            let dayView = self.contentView.selectVisibleDate(day)
            DispatchQueue.main.async {
                guard let view = dayView else { return }
                view.selected = true
            }
        }
    }
    
}
