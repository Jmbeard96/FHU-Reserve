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
import Moya
import Moya_ObjectMapper

class SearchViewController: UIViewController, JBDatePickerViewDelegate {
    
    @IBOutlet weak var calendar: JBDatePickerView!
    @IBOutlet weak var capacityPicker: UISegmentedControl!
    @IBOutlet weak var durationPicker: UISegmentedControl!
    
    @IBOutlet weak var dateLabel: UILabel!
    var primaryColor = UIColor.init(red: 102/255.0, green: 20/255.0, blue: 36/255.0, alpha: 1)
    var reserveProvider: MoyaProvider<FhuReserve>?
    var availableRooms: [AvailableRoomQueryResult]?
    var capacity: Int?
    var durationHours: Int?
    var searchDate: String?
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        reserveProvider = MoyaProvider<FhuReserve>()

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
    

    @IBAction func searchRooms(_ sender: Any) {
        let capacityIndex = capacityPicker.selectedSegmentIndex
        let durationIndex = durationPicker.selectedSegmentIndex
        let locationId = 1 // For now, we're only dealing with Freed-Hardeman Library
        let capacity = { () -> Int in
            switch capacityIndex {
            case 0:
                return 2
            case 1:
                return 4
            case 2:
                return 6
            default:
                return 2
            }
        }()
        let durationHours = { () -> Int in
            switch durationIndex {
            case 0:
                return 1
            case 1:
                return 2
            case 2:
                return 3
            default:
                return 1
            }
        }()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        let selectedDate = calendar.selectedDateView.date!
        let searchDate = dateFormatter.string(from: selectedDate)
        self.capacity = capacity
        self.durationHours = durationHours
        self.searchDate = searchDate
        reserveProvider?.request(.search(locationId: locationId, capacity: capacity, durationHours: durationHours, searchDate: searchDate )){ result in
            var success = true
            var message = "Unable to fetch from FHU Reserve"
            switch result {
            case let .success(response):
                do {
                    self.availableRooms = try response.mapArray(AvailableRoomQueryResult.self)
                    self.performSegue(withIdentifier: "DisplaySearchResults", sender: sender)
                } catch {
                    success = false
                }
            case let .failure(error):
                let error = error as CustomStringConvertible
                message = error.description
                success = false
            }
            if !success {
                let alert = UIAlertController(title: "Network Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DisplaySearchResults" {
            if let availableRoomsViewController = segue.destination as? AvailableRoomsTableViewController {
                availableRoomsViewController.queryResponse = availableRooms
                availableRoomsViewController.capacity = capacity
                availableRoomsViewController.durationHours = durationHours
                availableRoomsViewController.searchDate = searchDate
            }
        }
    }
    
}


