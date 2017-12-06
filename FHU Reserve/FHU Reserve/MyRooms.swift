//
//  MyRooms.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/17/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import Foundation

public class MyRooms{
    
    static var myRooms = [
        
        [Room(roomNumber: 205, imageName: "studyRoom" , amenities: ["White board", "TV"], reservedTime: "3:00pm - 4:00pm", capacity: 5)],
        [Room(roomNumber: 233, imageName: "roomThree", amenities: ["White board"], reservedTime: "10:00am - 12:00pm", capacity: 2)],
        [Room(roomNumber: 107, imageName: "roomTwo", amenities: ["TV"], reservedTime: "1:00pm - 3:00pm", capacity: 3)]
        ]

}
