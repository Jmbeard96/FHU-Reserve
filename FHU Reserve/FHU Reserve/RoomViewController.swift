//
//  RoomViewController.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/16/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {

    @IBOutlet weak var roomAmenities: UILabel!
    @IBOutlet weak var roomImage: UIImageView!
    var Room: Room?
    var section: Int?
    var row: Int?
    var tableViewIndex: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Room " + (Room?.roomNumber?.description)!
        
        roomImage?.image = UIImage(named: (Room?.imageName)!)
        
        if let amenityArray = Room?.amenities{
            var amenities = ""
            for amenity in amenityArray{
                if(amenityArray.count == 1){
                    amenities += amenity
                }
                else if(amenityArray.count == 2){
                    if(amenity == amenityArray[amenityArray.count - 1]){
                        amenities += amenity
                    }
                    else{
                        amenities += "\(amenity) and "
                    }
                }
                else{
                    if(amenity == amenityArray[amenityArray.count - 1]){
                        amenities += "and \(amenity)"
                    }
                    else{
                        amenities += (amenity + ", ")
                    }
                }
                
            }
            roomAmenities.text = amenities
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func reserve(_ sender: Any) {
        MyRooms.myRooms[0].append(RoomSet.roomsForTimes[section!][row!])
        RoomSet.roomsForTimes[section!].remove(at: row!)
        self.performSegue(withIdentifier: "unwindToFirstView", sender: self)
    }
    

    @IBAction func addToFavorites(_ sender: Any) {
        let dataSetIndex: Int = tableViewIndex! / 3
        let roomIndex = RoomSet.roomsForTimes[dataSetIndex].index(where: {$0.roomNumber == Room?.roomNumber })
        Room?.favorite = true
        RoomSet.roomsForTimes[dataSetIndex][roomIndex!] = Room!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
