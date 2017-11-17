//
//  RoomSet.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/13/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import Foundation

public class RoomSet{
    
    static var roomsForTimes = [[
        
        Room(roomNumber: 205, imageName: "studyRoom" , amenities: ["White board", "TV"], availableTimes: [9, 10, 13, 18], capacity: 5),
        Room(roomNumber: 233, imageName: "roomThree", amenities: ["White board"], availableTimes: [8, 9, 13, 15, 17, 22], capacity: 2),
        Room(roomNumber: 107, imageName: "roomTwo", amenities: ["TV"], availableTimes: [8, 9, 10, 13, 15, 16, 17, 20], capacity: 3)
    ],
    [
        Room(roomNumber: 233, imageName: "roomThree", amenities: ["White board"], availableTimes: [8, 9, 13, 15, 17, 22], capacity: 2),
        Room(roomNumber: 107, imageName: "roomTwo", amenities: ["TV"], availableTimes: [8, 9, 10, 13, 15, 16, 17, 20], capacity: 3)
    ],
    [

    Room(roomNumber: 205, imageName: "studyRoom" , amenities: ["White board", "TV"], availableTimes: [9, 10, 13, 18], capacity: 5),
    Room(roomNumber: 233, imageName: "roomThree", amenities: ["White board"], availableTimes: [8, 9, 13, 15, 17, 22], capacity: 2),
    ]]
    
}
