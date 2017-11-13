//
//  Room.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/13/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import Foundation

public class Room{
    
    var roomNumber: Int?
    var imageName: String?
    var amenities: [String]?
    var availableTimes: [Int]?
    
    init(roomNumber: Int, imageName: String, amenities: [String], availableTimes: [Int]) {
        
        self.roomNumber = roomNumber
        self.imageName = imageName
        self.amenities = amenities
        self.availableTimes = availableTimes
    }
    
}