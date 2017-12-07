//
//  Room.swift
//  FHU Reserve
//
//  Created by Jeremy Beard on 11/13/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import Foundation
import ObjectMapper

public class Room : Mappable {
    
    public init(roomName: String, imageUrl: String, amenities: [String], reservedTime: String, capacity: Int, favoriteRooms: [FavoriteRoom]?) {
        self.roomName = roomName
        self.imageUrl = imageUrl
        self.amenities = amenities
        self.capacity = capacity
        self.favoriteRooms = favoriteRooms
    }
    
    public required init?(map: Map) {
        
    }
    
    
    public func mapping(map: Map) {
        roomName <- map["name"]
        imageUrl <- map["imageUrl"]
        amenities <- map["roomFeatures.0.name"]
        capacity <- map["capacity"]
        favoriteRooms <- map["favoriteRooms"]
    }
    
    var roomName: String?
    var imageUrl: String?
    var amenities: [String]?
    var capacity: Int?
    var favoriteRooms: [FavoriteRoom]?
    
    func isFavorite() -> Bool {
        if(favoriteRooms == nil){
            return false
        }
        return favoriteRooms!.contains { $0.userId == 1 }
    }
    
}
