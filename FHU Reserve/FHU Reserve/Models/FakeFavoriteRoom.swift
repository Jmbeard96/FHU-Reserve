//
//  FakeFavoriteRoom.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 12/9/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import Foundation

class FakeFavoriteRoom{
    
    var imageName: String?
    var roomNumber: Int?
    var roomDescription: String
    
    init(imageName: String, roomNumber: Int, roomDescription: String) {
        self.imageName = imageName
        self.roomNumber = roomNumber
        self.roomDescription = roomDescription
    }
    
}
