//
//  MyRoomViewController.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/17/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import UIKit

class MyRoomViewController: UIViewController {

    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var reserveTime: UILabel!
    @IBOutlet weak var roomAmenities: UILabel!
    var Room: Room?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let roomNumber = Room?.roomNumber{
            navigationItem.title = "Room \(roomNumber)"
        }
        
        if let time = Room?.reservedTime{
            reserveTime.text = "Reserved for \(time)"
        }
        
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
        if let imageName = Room?.imageName{
            roomImage.image = UIImage(named: imageName)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
