//
//  SecondViewController.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/4/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myRooms = RoomSet.roomsForTimes
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myRooms.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRooms[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservedRoomCell", for: indexPath)
        
        if let reservedRoomCell = cell as? MyRoomsTableViewCell{
            reservedRoomCell.roomNumber.text = myRooms[indexPath.section][indexPath.row].roomNumber?.description
            if let imageName = myRooms[indexPath.section][indexPath.row].imageName{
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
        case 0: return "1:00pm - 2:00pm"
        case 1: return "2:00pm - 3:00pm"
        case 2: return "3:00pm - 4:00pm"
        default: return "TBA"
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

