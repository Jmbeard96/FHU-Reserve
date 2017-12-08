//
//  FavoriteRoom.swift
//  FHU Reserve
//
//  Created by Keith Mattix on 12/6/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import Foundation
import ObjectMapper

public class FavoriteRoom : Mappable {
    
    public init(userId: Int, roomId: Int) {
        self.userId = userId
        self.roomId = roomId
    }
    
    public func mapping(map: Map) {
        userId <- map["userId"]
        roomId <- map["roomId"]
    }
    public required init?(map: Map) {
        userId = map["userId"].value()!
        roomId = map["roomId"].value()!
    }
    
    var userId: Int
    var roomId: Int
}
