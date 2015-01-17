//
//  ViewController.swift
//  AdventureGameII
//
//  Created by Michael Reining on 1/17/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Game Grid - Harcoded for now
        
        var rooms = [
            Room(roomID: 0, roomType: .Empty, roomUp: nil, roomDown: 5, roomLeft: nil, roomRight: 2),
            Room(roomID: 1, roomType: .Empty, roomUp: nil, roomDown: 6, roomLeft: 1, roomRight: 3),
            Room(roomID: 2, roomType: .Empty, roomUp: nil, roomDown: 7, roomLeft: 2, roomRight: 4),
            Room(roomID: 3, roomType: .Empty, roomUp: nil, roomDown: 8, roomLeft: 3, roomRight: nil),
            Room(roomID: 4, roomType: .Empty, roomUp: 1, roomDown: 9, roomLeft: nil, roomRight: 6),
            Room(roomID: 5, roomType: .Empty, roomUp: 2, roomDown: 10, roomLeft: 5, roomRight: 7),
            Room(roomID: 6, roomType: .Empty, roomUp: 3, roomDown: 11, roomLeft: 6, roomRight: 8),
            Room(roomID: 7, roomType: .Empty, roomUp: 4, roomDown: 12, roomLeft: 7, roomRight: nil),
            Room(roomID: 8, roomType: .Empty, roomUp: 5, roomDown: 13, roomLeft: nil, roomRight: 10),
            Room(roomID: 9, roomType: .Empty, roomUp: 6, roomDown: 14, roomLeft: 9, roomRight: 11),
            Room(roomID: 10, roomType: .Empty, roomUp: 7, roomDown: 15, roomLeft: 10, roomRight: 12),
            Room(roomID: 11, roomType: .Empty, roomUp: 8, roomDown: 16, roomLeft: 11, roomRight: nil),
            Room(roomID: 12, roomType: .Empty, roomUp: 9, roomDown: nil, roomLeft: nil, roomRight: 14),
            Room(roomID: 13, roomType: .Empty, roomUp: 10, roomDown: nil, roomLeft: 9, roomRight: 15),
            Room(roomID: 14, roomType: .Empty, roomUp: 11, roomDown: nil, roomLeft: 10, roomRight: 16),
            Room(roomID: 15, roomType: .Empty, roomUp: 12, roomDown: nil, roomLeft: 11, roomRight: nil),
        ]
        
        var player = Player(currentRoom: nil, health: 2)
        
        // Setup room and player in Game Grid
        setupRooms(&rooms, player: &player)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Game Functions
    
    func setupRooms(inout rooms: [Room], inout player: Player) {
        // Add Treasure to random room
        let winningRoomID = Int(arc4random_uniform(16))
        rooms[winningRoomID].roomType = .Treasure
        println("\(rooms[winningRoomID].roomType.printString()) is in Room \(winningRoomID)")
        
        // Add cube to random room
        var cubeRoomID = Int(arc4random_uniform(16))
        while cubeRoomID == winningRoomID {
            cubeRoomID = Int(arc4random_uniform(16))
        }
        rooms[cubeRoomID].roomType = .Cube
        println("\(rooms[cubeRoomID].roomType.printString()) is in Room \(cubeRoomID)")
        
        // Add player to random room
        var initialPlayerRoom = Int(arc4random_uniform(16))
        while initialPlayerRoom == winningRoomID || initialPlayerRoom == cubeRoomID {
            initialPlayerRoom = Int(arc4random_uniform(16))
        }
        player.currentRoom = initialPlayerRoom
        println("PLAYER: is in Room \(player.currentRoom!)")
        
    }

}

