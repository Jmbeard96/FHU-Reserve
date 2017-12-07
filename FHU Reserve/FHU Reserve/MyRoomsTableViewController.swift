//
//  MyRoomsTableViewController.swift
//  
//
//  Created by Jeremy Beard on 11/29/17.
//

import UIKit

class MyRoomsTableViewController: UITableViewController {

    var myRooms = MyRooms.myRooms

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true


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
        return myRooms.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myRooms[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservedRoomCell", for: indexPath)
        
        if let reservedRoomCell = cell as? MyRoomsTableViewCell{
            let room = myRooms[indexPath.section][indexPath.row]
            
            if let roomNumber = room.roomNumber{
                reservedRoomCell.roomNumber.text = "Room \(roomNumber)"
            }
            if let time = room.reservedTime{
                reservedRoomCell.time.text = time
            }
            if let imageName = room.imageName{
                reservedRoomCell.roomImage?.image = UIImage(named: imageName)
            }
                
            else{
                reservedRoomCell.roomImage?.image = nil
            }
            
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section{
        case 0: return "November 24, 2017"
        case 1: return "November 26, 2017"
        case 2: return "November 27, 2017"
        default: return "TBA"
        }
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
            if segIdentifier == "MyRoomSegue" {
                if let MyRoomViewController = segue.destination as? MyRoomViewController,
                    let cell = sender as? UITableViewCell{
                    if let indexPath = tableView.indexPath(for: cell) {
                        let data = myRooms
                        MyRoomViewController.Room = data[indexPath.section][indexPath.row]
                    }
                }
                
            }
        }
    }
    

}
