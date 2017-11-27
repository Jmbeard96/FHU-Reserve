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
        
        navigationItem.title = "Room " + (Room?.roomNumber?.description)!
        
        var amenities = ""
        reserveTime.text = "Reserved for " + (Room?.reservedTime)!
        for amenity in (Room?.amenities)!{
            amenities += (amenity + ", ")
        }
        roomAmenities.text = amenities
        roomImage.image = UIImage(named: (Room?.imageName)!)

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
