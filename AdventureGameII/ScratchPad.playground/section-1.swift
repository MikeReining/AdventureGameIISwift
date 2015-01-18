import Foundation

// MARK: Setup Objects, Enums, and Structs

struct GameBoard {
    let rows: Int, columns: Int
    var squareType: SquareType
    var grid: [SquareType]
    init(rows: Int, columns: Int, squareType: SquareType) {
        self.rows = rows
        self.columns = columns
        self.squareType = squareType
        grid = Array(count: rows * columns, repeatedValue: squareType)
    }

}

enum SquareType: String {
    
    case Empty = "-"
    case Treasure = "T"
    case Cube = "C"
    
    var description: String {
        get {
            switch self {
            case .Empty:
                return "Empty\n"
            case .Treasure:
                return "Treasure\n"
            case .Cube:
                return "Cube\n"
            }
        }
    }
}

struct Player {
    var currentRoom: Int?
    var health = 2
}

// MARK: Setup Initial Game
// Setup Player
var player = Player(currentRoom: nil, health: 2)

// Setup Game Board

var defaultSquare = SquareType(rawValue: "-")
var gameBoard = GameBoard(rows: 4, columns: 4, squareType: defaultSquare!)

gameBoard.grid.count
gameBoard.squareType.description

// Setup Grid

func setupGameBoard() -> (Int,Int,Int) {
    // Add Treasure to random room
    var squareWithTreasure = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    while squareWithTreasure == 0 {
        squareWithTreasure = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    }
    
    // Add cube to random room
    var squareWithCube = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    while squareWithCube == squareWithTreasure {
        squareWithCube = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    }
    
    // Add player to random room
    player.currentRoom = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    while  player.currentRoom == squareWithTreasure || player.currentRoom == squareWithCube || player.currentRoom == 0 {
         player.currentRoom = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    }
    return (squareWithTreasure, squareWithCube,  player.currentRoom!)
}

let treasureRoom = setupGameBoard().0
let cubeRoom = setupGameBoard().1
player.currentRoom! = setupGameBoard().2
var allowedMoves = [Int]()

// MARK: Setup Game Logic Functions

func playerCanMoveTo(playerPosition: Int) -> [Int] {
    // Can move right? ➡︎ (forward by 1?)

    if playerPosition < gameBoard.grid.count && playerPosition % gameBoard.columns != 0 {
        allowedMoves.append(playerPosition + 1)
    }
    
    // Can move left ⬅︎ (backwards by 1?)
    if playerPosition > 1 && ((playerPosition + 3) % gameBoard.columns != 0){
        allowedMoves.append(playerPosition - 1)
    }

    // Can move down ⬇︎ one row
    if playerPosition <= (gameBoard.grid.count - gameBoard.columns) {
        allowedMoves.append(playerPosition + gameBoard.columns)
    }
 
    // Can move up ⬆︎ one row
    if playerPosition > (gameBoard.columns) {
        allowedMoves.append(playerPosition - gameBoard.columns)
    }
    return allowedMoves
}

func moveIsAllowed (allowedMoves: [Int], moveTo: Int) -> Bool {
    for (index, value) in enumerate(allowedMoves) {
        if value == moveTo {
            println("Move valid, you are moving to room #: \(moveTo)")
            return true
        }
    }
    println("Invalid Move.  You cannot move to room #: \(moveTo)")
    return false
}

func movePlayerTo(room:Int) {
    // Check if move is valid
    if moveIsAllowed(allowedMoves, room) {
        player.currentRoom = room
        for room in allowedMoves {
            if room == treasureRoom {
                println("YOU WIN - TREASURE FOUND!")
            }
            if room == cubeRoom && player.health == 1 {
                println("GAME OVER - You Lost this round")
            } else if room == cubeRoom && player.health > 1 {
                println("You stepped on the cube and lost half of your health")
                player.health -= 1
            }
        }
    }
}
player.currentRoom!
playerCanMoveTo(player.currentRoom!)







