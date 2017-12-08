//
//  MyRoomsTableViewController.swift
//  
//
//  Created by Jeremy Beard on 11/29/17.
//

import UIKit
import Alamofire
import AlamofireImage
import Moya
import Moya_ObjectMapper

class MyReservationsTableViewController: UITableViewController {

    var reservations: [Reservation]?
    var dateFormatter = DateFormatter()
    var provider: MoyaProvider<FhuReserve>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.dateFormatter.timeStyle = DateFormatter.Style.none
        self.dateFormatter.dateStyle = DateFormatter.Style.long
        if provider == nil {
            provider = MoyaProvider<FhuReserve>()
        }
        if (reservations == nil) {
            refreshReservations()
        }
        self.refreshControl?.addTarget(self, action: #selector(MyReservationsTableViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return reservations!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let dates = reservations?.grouped(by: { (reservation: Reservation) -> String in
            return dateFormatter.string(from: reservation.startTime)
        })
        let keys = Array(dates!.keys)
        let key = keys[section]
        return dates![key]!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservedRoomCell", for: indexPath)
        
        if let reservedRoomCell = cell as? MyReservationTableViewCell{
            let reservation = reservations![indexPath.section]
            let room = reservation.room
            
            if let roomName = room.roomName{
                reservedRoomCell.roomNumber.text = roomName
            }
            reservedRoomCell.time.text = dateFormatter.string(from: reservation.startTime)
            if let imageUrl = room.imageUrl{
                Alamofire.request(imageUrl).responseImage { response in
                    if let image = response.result.value {
                        reservedRoomCell.roomImage?.image = image
                    }
                }
            }
                
            else{
                reservedRoomCell.roomImage?.image = nil
            }
            
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dates = reservations?.grouped(by: { (reservation: Reservation) -> String in
            return dateFormatter.string(from: reservation.startTime)
        })
        let keys = Array(dates!.keys)
        return keys[section]
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
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        refreshReservations()
        refreshControl.endRefreshing()
    }
    
    func refreshReservations() {
        provider?.request(.getReservations(reserverId: 1)) { result in
            var success = true
            var message = "Unable to fetch your reservations"
            switch result {
            case let .success(response):
                do {
                    self.reservations = try response.mapArray(Reservation.self)
                    self.tableView.reloadData()
                } catch {
                    success = false
                }
            case let .failure(error):
                let error = error as CustomStringConvertible
                message = error.description
                success = false
            }
            if !success{
                let alert = UIAlertController(title: "Network Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segIdentifier = segue.identifier {
            if segIdentifier == "MyRoomSegue" {
                if let reservationViewController = segue.destination as? MyReservationViewController,
                    let cell = sender as? UITableViewCell{
                    if let indexPath = tableView.indexPath(for: cell) {
                        let groupedReservations = reservations?.grouped(by: { (reservation: Reservation) -> String in
                            return dateFormatter.string(from: reservation.startTime)
                        })
                        let keys = Array(groupedReservations!.keys)
                        let key = keys[indexPath.section]
                        reservationViewController.reservation = groupedReservations![key]?[indexPath.row]
                    }
                }
                
            }
        }
    }
    

}
