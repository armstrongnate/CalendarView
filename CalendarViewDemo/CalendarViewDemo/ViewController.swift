//
//  ViewController.swift
//  CalendarViewDemo
//
//  Created by Nate Armstrong on 5/7/15.
//  Copyright (c) 2015 Nate Armstrong. All rights reserved.
//

import UIKit
import CalendarView
import SwiftMoment

class ViewController: UIViewController {

  @IBOutlet weak var calendar: CalendarView!

  var date: Moment! {
    didSet {
      title = date.format(dateFormat: "MMMM d, yyyy")
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    date = moment()
    calendar.delegate = self
  }

}

extension ViewController: CalendarViewDelegate {

  func calendarDidSelectDate(date: Moment) {
    self.date = date
  }

  func calendarDidPageToDate(date: Moment) {
    self.date = date
  }

}
