//
//  FhuReserve.swift
//  FHU Reserve
//
//  Created by Keith Mattix on 12/6/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import Foundation
import Moya

enum FhuReserve {
    case showRoom(id: Int)
    case reserveRoom(reserverId: Int, roomId: Int, startTime: Date, endTime: Date)
    case favoriteRoom(id: Int, userId: Int)
    case unFavoriteRoom(id: Int, userId: Int)
    case search(locationId: Int, capacity: Int, durationHours: Int, searchDate: Date)
    case searchRoom(roomId: Int, durationHours: Int, searchDate: Date)
    case cancelReservation(reservationId: Int)
}

extension FhuReserve : TargetType {
    var baseURL: URL { return URL(string: "https://fhureserve.azurewebsites.net/api")! }
    
    var path: String {
        switch self {
        case .showRoom(let id):
            return "/room/\(id)"
        case .reserveRoom(_, _, _, _):
            return "/reservations"
        case .favoriteRoom(let id, _):
            return "/rooms/\(id)/"
        case .unFavoriteRoom(let id, _):
            return "/rooms/\(id)"
        case .search(let locationId, let capacity, let durationHours, let searchDate):
            return "/schedules/search?locationId=\(locationId)&capacity\(capacity)=&durationHours=\(durationHours)&searchDate=\(searchDate.description)"
        case .searchRoom(let roomId, let durationHours, let searchDate):
            return "/rooms/search?roomId=\(roomId)&durationHours=\(durationHours)&searchDate=\(searchDate.description)"
        case .cancelReservation(let reservationId):
            return "/reservations/\(reservationId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .showRoom, .search, .searchRoom:
            return .get
        case .reserveRoom, .favoriteRoom, .unFavoriteRoom:
            return .post
        case .cancelReservation:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .showRoom, .cancelReservation:
            return .requestPlain
        case let .reserveRoom(reserverId, roomId, startTime, endTime):
            return .requestParameters(parameters: ["reserverId": reserverId, "roomId": roomId, "startTime": startTime, "endTime": endTime], encoding: JSONEncoding.default)
        case let .search(locationId, capacity, durationHours, searchDate):
            return .requestParameters(parameters: ["locationId": locationId, "capacity": capacity, "durationHours": durationHours, "searchDate": searchDate], encoding: URLEncoding.queryString)
        case let .searchRoom(roomId, durationHours, searchDate):
            return .requestParameters(parameters: ["roomId": roomId, "durationHours": durationHours, "searchDate": searchDate], encoding: URLEncoding.queryString)
        case let .favoriteRoom(_, userId):
            return .requestParameters(parameters: ["userId": userId], encoding: JSONEncoding.default)
        case let .unFavoriteRoom(_, userId):
            return .requestParameters(parameters: ["userId": userId], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

