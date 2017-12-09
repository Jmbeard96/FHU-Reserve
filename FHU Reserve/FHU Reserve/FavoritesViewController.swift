//
//  RoomViewController.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/16/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import UIKit


class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var roomDescription: UILabel!
    @IBOutlet weak var roomImage: UIImageView!
    
    var room: FakeFavoriteRoom?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = (room?.roomNumber?.description)!
        
        if let imageName = room?.imageName{
            roomImage.image = UIImage(named: imageName)
        }
        else{
            roomImage.image = nil
        }
        if let description = room?.roomDescription{
            roomDescription.text = description
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



