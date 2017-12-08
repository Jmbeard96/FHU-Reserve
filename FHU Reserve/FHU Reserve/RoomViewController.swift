//
//  RoomViewController.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/16/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Moya
import Moya_ObjectMapper

class RoomViewController: UIViewController {

    @IBOutlet weak var roomDescription: UILabel!
    @IBOutlet weak var roomImage: UIImageView!
    var room: Room?
    var tableViewIndex: Int?
    var reserveProvider: MoyaProvider<FhuReserve>?
    var startTime: String?
    var endTime: String?
    var roomId: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = (room?.roomName?.description)!
        
        Alamofire.request(room!.imageUrl!).responseImage { response in
            if let image = response.result.value {
                self.roomImage?.image = image
            }
        }
        roomDescription.text = room?.description!
        reserveProvider = MoyaProvider<FhuReserve>()
    }
    


    @IBAction func addToFavorites(_ sender: Any) {

    }
    

    @IBAction func reserveRoom(_ sender: Any) {
        let reservationFormatter = DateFormatter()
        let dateFormatter = DateFormatter()
        reservationFormatter.dateFormat = "MM/dd/yyyy h:mm:ss a"
        let startTimeDate = reservationFormatter.date(from: startTime!)
        let endTimeDate = reservationFormatter.date(from: endTime!)
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let startTimeString = dateFormatter.string(from: startTimeDate!)
        let endTimeString = dateFormatter.string(from: endTimeDate!)
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: startTimeDate!)
        let confirm = UIAlertController(title: "Reserve Room", message: "Are you sure you want to reserve this room from \(startTimeString) to \(endTimeString) on \(dateString)?", preferredStyle: UIAlertControllerStyle.alert)
        confirm.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { _ in
            self.searchRooms(sender)
        }))
        confirm.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(confirm, animated: true, completion: nil)
    }
    
    func searchRooms(_ sender: Any) {
        reserveProvider?.request(.reserveRoom(reserverId: 1, roomId: roomId!, startTime: startTime!, endTime: endTime!)) { result in
            var success = true
            var message = "Unable to make your reservation"
            switch result {
            case .success:
                let alert = UIAlertController(title: "Success!", message: "Your reservation was successfully placed!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { _ in
                    let viewControllers = self.navigationController!.viewControllers
                    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
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
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


