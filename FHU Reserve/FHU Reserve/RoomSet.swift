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
        
        Room(roomNumber: 205, imageName: "studyRoom" , amenities: ["White board", "TV"], reservedTime: "3:00pm - 4:00pm", capacity: 5),
        Room(roomNumber: 233, imageName: "roomThree", amenities: ["White board"], reservedTime: "3:00pm - 4:00pm", capacity: 2),
        Room(roomNumber: 107, imageName: "roomTwo", amenities: ["TV"], reservedTime: "3:00pm - 4:00pm", capacity: 3)
    ],
    [
        Room(roomNumber: 233, imageName: "roomThree", amenities: ["White board"], reservedTime: "3:00pm - 4:00pm", capacity: 2),
        Room(roomNumber: 107, imageName: "roomTwo", amenities: ["TV"], reservedTime: "3:00pm - 4:00pm", capacity: 3)
    ],
    [

    Room(roomNumber: 205, imageName: "studyRoom" , amenities: ["White board", "TV"], reservedTime: "3:00pm - 4:00pm", capacity: 5),
    Room(roomNumber: 233, imageName: "roomThree", amenities: ["White board"], reservedTime: "3:00pm - 4:00pm", capacity: 2),
    ]]
    
}
