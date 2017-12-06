//
//  SearchViewController.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/7/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import Foundation
import UIKit
import JBDatePicker

class SearchViewController: UIViewController, JBDatePickerViewDelegate {
    
    @IBOutlet weak var calendar: JBDatePickerView!
    @IBOutlet weak var capacityPicker: UISegmentedControl!
    @IBOutlet weak var durationPicker: UISegmentedControl!
    
    @IBOutlet weak var dateLabel: UILabel!
    var primaryColor = UIColor.init(red: 102/255.0, green: 20/255.0, blue: 36/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendar.delegate = self
        calendar.heightAnchor.constraint(equalToConstant: 275).isActive = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateLabel.text = dateFormatter.string(from: calendar.selectedDateView.date!)
    }
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateLabel.text = dateFormatter.string(from: dayView.date!)
    }
    
    var colorForWeekDaysViewBackground: UIColor { return primaryColor }
    
    var colorForSelectionCircleForOtherDate: UIColor { return primaryColor }
    
    var colorForSelectionCircleForToday: UIColor { return primaryColor }
    
    func shouldAllowSelectionOfDay(_ date: Date?) -> Bool {
        let currentDate = Date()
        //this code example disables selection for dates older then today
        guard let date = date else {return true}
        let comparison = NSCalendar.current.compare(date, to: currentDate, toGranularity: .day)
        
        if comparison == .orderedAscending {
            return false
        }
        
        // this part prevents selecting dates further than two weeks in the future
        var dateComponent = DateComponents()
        dateComponent.day = 14 // Add 2 weeks
        let twoWeeksFromNow = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        let twoWeeksComparison = NSCalendar.current.compare(date, to: twoWeeksFromNow!, toGranularity: .day)
        if twoWeeksComparison == .orderedDescending {
            return false
        }
        return true
    }


}


