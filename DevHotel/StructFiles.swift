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
    let lastNamt: String
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
}

// Equatable protocal implementation for RoomType
func ==(lhs: RoomType, rhs: RoomType) -> Bool {
    return lhs.id == rhs.id
}
