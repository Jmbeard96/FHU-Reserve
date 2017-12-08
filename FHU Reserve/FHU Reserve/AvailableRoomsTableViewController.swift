//
//  AvailableRoomsTableViewController.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/14/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Moya
import Moya_ObjectMapper

class AvailableRoomsTableViewController: UITableViewController {

    var queryResponse: [AvailableRoomQueryResult]?
    var durationHours: Int?
    var capacity: Int?
    var locationId = 1
    var searchDate: String?
    var dateFormatter = DateFormatter()
    var reserveProvider: MoyaProvider<FhuReserve>?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.dateFormatter.timeStyle = DateFormatter.Style.short
        self.dateFormatter.dateStyle = DateFormatter.Style.none
        if reserveProvider == nil {
            reserveProvider = MoyaProvider<FhuReserve>()
        }

        self.refreshControl?.addTarget(self, action: #selector(AvailableRoomsTableViewController.refreshRooms(_:)), for: UIControlEvents.valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return queryResponse!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return queryResponse![section].rooms!.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let reservationFormatter = DateFormatter()
        reservationFormatter.dateFormat = "MM/dd/yyyy h:mm:ss a"
        let startTime = reservationFormatter.date(from: queryResponse![section].startTime)
        let endTime = reservationFormatter.date(from: queryResponse![section].endTime)
        return "\(dateFormatter.string(from: startTime!)) - \(dateFormatter.string(from: endTime!))"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath)

        if let roomCell = cell as? AvailableRoomTableViewCell{
            roomCell.roomName.text = queryResponse![indexPath.section].rooms![indexPath.row].roomName
            roomCell.roomDescription.text = queryResponse![indexPath.section].rooms![indexPath.row].description
            if let imageUrl = queryResponse![indexPath.section].rooms![indexPath.row].imageUrl {
                Alamofire.request(imageUrl).responseImage { response in
                    if let image = response.result.value {
                        roomCell.roomImage.image = image
                    }
                }
            }
            else{
                roomCell.roomImage?.image = nil
            }
            
        }

        return cell
    }
    
    @objc func refreshRooms(_ refreshControl: UIRefreshControl) {
        reserveProvider?.request(.search(locationId: locationId, capacity: capacity!, durationHours: durationHours!, searchDate: searchDate! )){ result in
            var success = true
            var message = "Unable to fetch from FHU Reserve"
            switch result {
            case let .success(response):
                do {
                    self.queryResponse = try response.mapArray(AvailableRoomQueryResult.self)
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
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let segIdentifier = segue.identifier {
            if segIdentifier == "RoomSegue" {
                if let roomViewController = segue.destination as? RoomViewController,
                    let cell = sender as? UITableViewCell
                     {
                    if let indexPath = tableView.indexPath(for: cell) {
                        let data = queryResponse!
                        let startTime = data[indexPath.section].startTime
                        let endTime = data[indexPath.section].endTime
                        roomViewController.room = data[indexPath.section].rooms![indexPath.row]
                        roomViewController.startTime = startTime
                        roomViewController.endTime = endTime
                        roomViewController.roomId = roomViewController.room?.id
                        roomViewController.tableViewIndex = indexPath.row
                    }
                }
                
            }
        }
        
    }
    

}
