//
//  SecondViewController.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/4/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myRoomsTableView: UITableView!
    var myRooms = MyRooms.myRooms
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservedRoomCell", for: indexPath)
        
        if let reservedRoomCell = cell as? MyRoomsTableViewCell{
            reservedRoomCell.roomNumber.text = "Room " +
                (myRooms[indexPath.row].roomNumber?.description)!
            reservedRoomCell.time.text = myRooms[indexPath.row].reservedTime
            if let imageName = myRooms[indexPath.row].imageName{
                reservedRoomCell.roomImage?.image = UIImage(named: imageName)
            }
            else{
                reservedRoomCell.roomImage?.image = nil
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section{
        case 0: return "November 24, 2017"
        case 1: return "November 26, 2017"
        case 2: return "November 27, 2017"
        default: return "TBA"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segIdentifier = segue.identifier {
            if segIdentifier == "MyRoomSegue" {
                if let MyRoomViewController = segue.destination as? MyRoomViewController,
                    let cell = sender as? UITableViewCell{
                    if let indexPath = myRoomsTableView.indexPath(for: cell) {
                        let data = myRooms
                        MyRoomViewController.Room = data[indexPath.row]
                    }
                }
                
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Rooms"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

