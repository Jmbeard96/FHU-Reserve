//
//  Reservation.swift
//  FHU Reserve
//
//  Created by Keith Mattix on 12/7/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import Foundation
import ObjectMapper

public class Reservation : Mappable {
    
    var roomId: Int
    var room: Room
    var reserverId: Int
    var confirmationCode: String
    var startTime: Date
    var endTime: Date
    
    public init(roomId: Int, room: Room, reserverId: Int, confirmationCode: String, startTime: Date, endTime: Date){
        self.roomId = roomId
        self.room = room
        self.reserverId = reserverId
        self.confirmationCode = confirmationCode
        self.startTime = startTime
        self.endTime = endTime
    }
    
    public func mapping(map: Map) {
        roomId <- map["roomId"]
        room <- map["room"]
        reserverId <- map["reserverId"]
        confirmationCode <- map["confirmationCode"]
        startTime <- map["startTime"]
        endTime <- map["endTime"]
    }
    
    public required init?(map: Map) {
        roomId = map["roomId"].value()!
        room = map["room"].value()!
        reserverId = map["reserverId"].value()!
        confirmationCode = map["confirmationCode"].value()!
        startTime = map["startTime"].value()!
        endTime = map["endTime"].value()!
    }

}
