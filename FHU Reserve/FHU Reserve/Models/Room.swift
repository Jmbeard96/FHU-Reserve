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
    
    public init(roomName: String, imageUrl: String, amenities: [String], reservedTime: String, capacity: Int, favoriteRooms: [FavoriteRoom]?, description: String, id: Int) {
        self.roomName = roomName
        self.imageUrl = imageUrl
        self.amenities = amenities
        self.capacity = capacity
        self.favoriteRooms = favoriteRooms
        self.description = description
        self.id = id
    }
    
    public required init?(map: Map) {
        
    }
    
    
    public func mapping(map: Map) {
        roomName <- map["name"]
        imageUrl <- map["imageUrl"]
        amenities <- map["roomFeatures.0.name"]
        capacity <- map["capacity"]
        favoriteRooms <- map["favoriteRooms"]
        description <- map["description"]
        id <- map["id"]
    }
    
    var roomName: String?
    var imageUrl: String?
    var amenities: [String]?
    var description: String?
    var capacity: Int?
    var favoriteRooms: [FavoriteRoom]?
    var id: Int?
    
    func isFavorite() -> Bool {
        if(favoriteRooms == nil){
            return false
        }
        return favoriteRooms!.contains { $0.userId == 1 }
    }
    
}
