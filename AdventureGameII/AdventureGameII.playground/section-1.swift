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
var gameBoard = GameBoard(rows: 3, columns: 3, squareType: defaultSquare!)

gameBoard.grid.count
gameBoard.squareType.description

// Setup Grid
var squareWithTreasure: Int?
var squareWithCube: Int?



func setupGameBoard() -> (Int,Int,Int) {
    // Add Treasure to random room
    squareWithTreasure = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    while squareWithTreasure == 0 {
        squareWithTreasure = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    }
    
    // Add cube to random room
    squareWithCube = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    while squareWithCube == squareWithTreasure {
        squareWithCube = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    }
    
    // Add player to random room (BUG player ended in cube room.
    player.currentRoom = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    while  player.currentRoom == squareWithTreasure || player.currentRoom == squareWithCube || player.currentRoom == 0 {
        player.currentRoom = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    }
    return (squareWithTreasure!, squareWithCube!,  player.currentRoom!)
}

setupGameBoard()

var allowedMoves = [Int]()

// MARK: Setup Game Logic Functions

func playerCanMoveTo(playerPosition: Int) -> [Int] {
    // Can move right? ➡︎ (forward by 1?)
    
    if playerPosition < gameBoard.grid.count && playerPosition % gameBoard.columns != 0 {
        allowedMoves.append(playerPosition + 1)
    }
    
    // Can move left ⬅︎ (backwards by 1?)
    if playerPosition > 1 && ((playerPosition + gameBoard.columns - 1) % gameBoard.columns != 0){
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

func movePlayerTo(moveToRoom:Int) {
    // Check if move is valid
    if moveIsAllowed(allowedMoves,moveToRoom) {
        player.currentRoom = moveToRoom
        for room in allowedMoves {
            if room == squareWithTreasure && room == moveToRoom {
                println("YOU WIN - TREASURE FOUND!")
            }
            if room == squareWithCube && room == moveToRoom && player.health == 1 {
                println("GAME OVER - You Lost this round")
            } else if room == squareWithCube && room == moveToRoom && player.health > 1 {
                println("You stepped on the cube and lost half of your health")
                player.health -= 1
            }
        }
    }
}

squareWithCube
squareWithTreasure
player.currentRoom!
playerCanMoveTo(player.currentRoom!)
movePlayerTo(6)










