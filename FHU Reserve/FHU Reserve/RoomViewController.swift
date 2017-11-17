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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomImage?.image = UIImage(named: (Room?.imageName)!)
        var amenities = ""
        
        for amenity in (Room?.amenities)!{
            amenities += (amenity + ", ")
        }
        roomAmenities.text = amenities

        // Do any additional setup after loading the view.
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
