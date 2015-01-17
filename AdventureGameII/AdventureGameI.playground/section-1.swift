// Playground - noun: a place where people can play

// OUT OF TIME - only managed to complete a small part of assignment.  :(

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
            return "TREASURE:"
        case Cube:
            return "CUBE"
        }
    }
}

struct Player {
    var currentRoom: Int?
    var health = 2
}


func currentRoom(player: Player) {
    player.currentRoom
    player.health
}



// Create Array with 16 Rooms
// NOTE First hardcoding this.  Obviously, this should be generated programatically.  Just did not have
// have the time to think about how and got stuck and wanted to move on to try to implement some of the other
// game logic

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

rooms.count

var player = Player(currentRoom: nil, health: 2)

//// Assign cube to random room
//let winningRoomID = Int(arc4random_uniform(16))
//Rooms[winningRoomID].roomType = .Treasure
//println("Room \(winningRoomID) - \(Rooms[winningRoomID].roomType.printString())")
//
//// Assign cube to random room
//// Refactor later... right now the cube and treasure can be in the same room
//let cubeRoomID = Int(arc4random_uniform(16))
//Rooms[cubeRoomID].roomType = .Cube
//println("Room \(cubeRoomID) - \(Rooms[cubeRoomID].roomType.printString())")

// MARK: Game Functions

func setupRooms(inout rooms: [Room], inout player: Player) {
    // Add Treasure to random room
    let winningRoomID = Int(arc4random_uniform(16))
    rooms[winningRoomID].roomType = .Treasure
    println("\(rooms[winningRoomID].roomType.printString()) - Room \(winningRoomID)")
    
    // Add cube to random room
    var cubeRoomID = Int(arc4random_uniform(16))
    while cubeRoomID == winningRoomID {
        cubeRoomID = Int(arc4random_uniform(16))
    }
    rooms[cubeRoomID].roomType = .Cube
    println("\(rooms[cubeRoomID].roomType.printString()) - Room \(cubeRoomID)")
    
    // Add player to random room
    var initialPlayerRoom = Int(arc4random_uniform(16))
    while initialPlayerRoom == winningRoomID || initialPlayerRoom == cubeRoomID {
        initialPlayerRoom = Int(arc4random_uniform(16))
    }
    player.currentRoom = initialPlayerRoom
    println("PLAYER CURRENT ROOM: \(player.currentRoom!)")
    
}

setupRooms(&rooms, &player)

//Check Room setup - was array updated successfully?

player.currentRoom

func whatHappensInNewRoom (inout player: Player, room: Room) {
    if room.roomType == .Treasure {
        println("You found the treasure!  Game Won!")
    } else if room.roomType == .Cube {
        if player.health == 1 {
            println("GAME OVER - Your are out of health")
        } else {
            player.health -= 1
            println("Oh no!  You found the cube and lost health.  Your health is now \(player.health)")
        }
    } else {
        println("You found an empty room, time to move again")
    }
}

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
    
    whatHappensInNewRoom(&player, possibleRooms[newRoom])
    
}

moveToRoom(&player, rooms)









