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
            Room(roomID: 0, roomType: .Empty, roomUp: nil, roomDown: 4, roomLeft: nil, roomRight: 1),
            Room(roomID: 1, roomType: .Empty, roomUp: nil, roomDown: 5, roomLeft: 0, roomRight: 2),
            Room(roomID: 2, roomType: .Empty, roomUp: nil, roomDown: 6, roomLeft: 1, roomRight: 3),
            Room(roomID: 3, roomType: .Empty, roomUp: nil, roomDown: 7, roomLeft: 2, roomRight: nil),
            Room(roomID: 4, roomType: .Empty, roomUp: 0, roomDown: 8, roomLeft: nil, roomRight: 5),
            Room(roomID: 5, roomType: .Empty, roomUp: 1, roomDown: 9, roomLeft: 4, roomRight: 6),
            Room(roomID: 6, roomType: .Empty, roomUp: 2, roomDown: 10, roomLeft: 5, roomRight: 7),
            Room(roomID: 7, roomType: .Empty, roomUp: 3, roomDown: 11, roomLeft: 6, roomRight: nil),
            Room(roomID: 8, roomType: .Empty, roomUp: 4, roomDown: 12, roomLeft: nil, roomRight: 9),
            Room(roomID: 9, roomType: .Empty, roomUp: 5, roomDown: 13, roomLeft: 8, roomRight: 10),
            Room(roomID: 10, roomType: .Empty, roomUp: 6, roomDown: 14, roomLeft: 9, roomRight: 11),
            Room(roomID: 11, roomType: .Empty, roomUp: 7, roomDown: 15, roomLeft: 10, roomRight: nil),
            Room(roomID: 12, roomType: .Empty, roomUp: 8, roomDown: nil, roomLeft: nil, roomRight: 13),
            Room(roomID: 13, roomType: .Empty, roomUp: 9, roomDown: nil, roomLeft: 12, roomRight: 14),
            Room(roomID: 14, roomType: .Empty, roomUp: 10, roomDown: nil, roomLeft: 13, roomRight: 15),
            Room(roomID: 15, roomType: .Empty, roomUp: 11, roomDown: nil, roomLeft: 14, roomRight: nil),
        ]
        
        var player = Player(currentRoom: nil, health: 2)
        
        // Setup room and player in Game Grid
        setupRooms(&rooms, player: &player)

        moveToRoom(&player, rooms: rooms)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Game Functions
    
    // Setup Initial Rooms with Treasure, Cube, and Player in random Room
    func setupRooms(inout rooms: [Room], inout player: Player) {
        // Add Treasure to random room
        let winningRoomID = Int(arc4random_uniform(15))
        rooms[winningRoomID].roomType = .Treasure
        println("\(rooms[winningRoomID].roomType.printString()) is in Room \(winningRoomID)")
        
        // Add cube to random room
        var cubeRoomID = Int(arc4random_uniform(15))
        while cubeRoomID == winningRoomID {
            cubeRoomID = Int(arc4random_uniform(15))
        }
        rooms[cubeRoomID].roomType = .Cube
        println("\(rooms[cubeRoomID].roomType.printString()) is in Room \(cubeRoomID)")
        
        // Add player to random room
        var initialPlayerRoom = Int(arc4random_uniform(15))
        while initialPlayerRoom == winningRoomID || initialPlayerRoom == cubeRoomID {
            initialPlayerRoom = Int(arc4random_uniform(15))
        }
        player.currentRoom = initialPlayerRoom
        println("PLAYER: is in Room \(player.currentRoom!)")
        
    }
     
    // Function to move player
    
    func moveToRoom(inout player: Player, rooms: [Room]) {
        var currentRoom = player.currentRoom!
        var possibleRooms = [Int]()
        
        if let possibleRoom1 = rooms[currentRoom].roomUp {
            possibleRoom1
            possibleRooms.append(possibleRoom1)
        }
        if let possibleRoom2 = rooms[currentRoom].roomDown {
            possibleRoom2
            possibleRooms.append(possibleRoom2)
            
        }
        if let possibleRoom3 = rooms[currentRoom].roomLeft? {
            possibleRoom3
            possibleRooms.append(possibleRoom3)
        }
        if let possibleRoom4 = rooms[currentRoom].roomRight {
            possibleRoom4
            possibleRooms.append(possibleRoom4)
        }
        println("You can move to one of the following Rooms")
        for room in possibleRooms {
            print("\(room) ")
        }
        println("- Which room would you like to pick?")
        // Move Player to one of new rooms
        let randomIndex = Int(arc4random_uniform(UInt32(possibleRooms.count)))
        var newRoom = possibleRooms[randomIndex]
        println("Player is moving to new room #: \(newRoom)")
        
        // Determine what happens in new room
        
    }

}

