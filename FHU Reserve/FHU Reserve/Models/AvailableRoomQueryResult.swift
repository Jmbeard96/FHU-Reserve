//
//  AvailableRoomQueryResponse.swift
//  FHU Reserve
//
//  Created by Keith Mattix on 12/7/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import Foundation
import ObjectMapper

public class AvailableRoomQueryResult : Mappable {
    

    public required init?(map: Map) {
        self.rooms = map["rooms"].value()
        self.startTime = map["startTime"].value()!
        self.endTime = map["endTime"].value()!
        self.numberOfRooms = map["numberOfRooms"].value()!
    }
    
    public func mapping(map: Map) {
        rooms <- map["rooms"]
        startTime <- map["startTime"]
        endTime <- map["endtime"]
        numberOfRooms <- map["numberOfRooms"]
    }
    
    var rooms: [Room]?
    var numberOfRooms: Int
    var startTime: String
    var endTime: String
    
}
