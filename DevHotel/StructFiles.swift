//
//  StructFiles.swift
//  Dev Hotel
//
//  Created by Devontae Reid on 12/18/17.
//  Copyright © 2017 Devontae Reid. All rights reserved.
//

import Foundation

struct Registration {
    let firstName: String
    let lastName: String
    let email: String
    
    let checkInDate: Date
    let checkOutDate: Date
    let numberOfAdults: Int
    let numberOfChildren: Int
    
    let roomType: RoomType
    let wifi: Bool
}

struct RoomType: Equatable {
    let id: Int
    let name: String
    let shortName: String
    let price: Int
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Single Twin", shortName: "ST", price: 150),RoomType(id: 1, name: "Double Twin", shortName: "DDQ", price: 180),RoomType(id: 2, name: "Double Queen", shortName: "DQ", price: 220),RoomType(id: 3, name: "Double Double Queen", shortName: "DDQ", price: 290)]
    }
}

// Equatable protocal implementation for RoomType
func ==(lhs: RoomType, rhs: RoomType) -> Bool {
    return lhs.id == rhs.id
}
