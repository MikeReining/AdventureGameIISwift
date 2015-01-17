//
//  Room.swift
//  AdventureGame
//
//  Created by Michael Reining on 1/17/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import Foundation

struct Room {
    var roomID: Int
    var roomType: RoomType
    var roomUp: Int?
    var roomDown: Int?
    var roomLeft: Int?
    var roomRight: Int?
}

enum RoomType {
    case Empty, Treasure, Cube
    func printString() -> String {
        switch self {
        case Empty:
            return "EMPTY"
        case Treasure:
            return "TREASURE"
        case Cube:
            return "CUBE"
        }
    }
}

func currentRoom(player: Player) {
    player.currentRoom
    player.health
}

