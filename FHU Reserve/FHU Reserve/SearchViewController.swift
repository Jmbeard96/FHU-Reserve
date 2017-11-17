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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendar.delegate = self
        
    }
    func didSelectDay(_ dayView: JBDatePickerDayView) {
        
    }
}


