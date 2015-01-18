import Foundation



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

var defaultSquare = SquareType(rawValue: "-")
var gameBoard = GameBoard(rows: 4, columns: 4, squareType: defaultSquare!)

gameBoard.grid.count
gameBoard.squareType.description

// Setup Grid

func setupGameBoard() -> (Int,Int,Int) {
    // Add Treasure to random room
    let squareWithTreasure = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    
    // Add cube to random room
    var squareWithCube = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    while squareWithCube == squareWithTreasure {
        squareWithCube = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    }
    
    // Add player to random room
    var squareWithPlayer = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    while squareWithPlayer == squareWithTreasure || squareWithPlayer == squareWithCube {
        squareWithPlayer = Int(arc4random_uniform(UInt32(gameBoard.grid.count)))
    }
    return (squareWithTreasure, squareWithCube, squareWithPlayer)
}


setupGameBoard().0

// Figure out where player can move to

func playerCanMoveTo(playerPosition: Int) -> (Int?,Int?,Int?,Int?) {
    // Can move right? (forward by 1?)
    var playerCanMoveRightTo: Int?
    var playerCanMoveLeftTo: Int?
    var playerCanMoveDownTo: Int?
    var playerCanMoveUpTo: Int?

    var playerCanMoveRight: Bool = false
    if playerPosition < gameBoard.grid.count {
        playerCanMoveRight = true
        playerCanMoveRightTo = playerPosition + 1
    }
    
    // Can move left (backwards by 1?)
    var playerCanMoveLeft: Bool = false
    if playerPosition > 1 {
        playerCanMoveLeft = true
        playerCanMoveLeftTo = playerPosition - 1
    }

    // Can move down one row
    var playerCanMoveDown: Bool = false
    if playerPosition <= (gameBoard.grid.count - gameBoard.columns) {
        playerCanMoveDown = true
        playerCanMoveDownTo = playerPosition + gameBoard.columns
    }
 
    // Can move up one row
    var playerCanMoveUp: Bool = false
    if playerPosition > (gameBoard.grid.count - gameBoard.columns) {
        playerCanMoveUp = true
        playerCanMoveUpTo = playerPosition - gameBoard.columns
    }
    return (playerCanMoveRightTo,playerCanMoveLeftTo,playerCanMoveDownTo,playerCanMoveUpTo)
}

playerCanMoveTo(setupGameBoard().2).0





