//
//  MyRoomViewController.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/17/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MyReservationViewController: UIViewController {

    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var reserveTime: UILabel!
    @IBOutlet weak var roomAmenities: UILabel!
    var reservation: Reservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        let room = reservation?.room
        if let roomName = room?.roomName{
            navigationItem.title = roomName
        }
        
        let reservationFormatter = DateFormatter()
        let dateFormatter = DateFormatter()
        reservationFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let startTimeDate = reservationFormatter.date(from: (reservation?.startTime!)!)
        let endTimeDate = reservationFormatter.date(from: (reservation?.endTime!)!)
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let startTimeString = dateFormatter.string(from: startTimeDate!)
        let endTimeString = dateFormatter.string(from: endTimeDate!)
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        reserveTime.text = "Reserved for \(startTimeString) - \(endTimeString)"
        
        roomAmenities.text = reservation?.room?.description
        if let imageUrl = room?.imageUrl{
            Alamofire.request(imageUrl).responseImage { response in
                if let image = response.result.value {
                    self.roomImage.image = image
                }
            }
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
