import Foundation
enum PlayerColor:String {
    
    case None = "-"
    case Red = "r"
    case Black = "b"
    
    var description: String {
        get {
            switch self {
            case .None:
                return "None\n"
            case .Red:
                return "Red\n"
            case .Black:
                return "Black\n"
            }
        }
    }
}


class GameBoard {
    var board: [[PlayerColor]] = []
    
    func empty() -> PlayerColor {
        return .None
    }
    func red() -> PlayerColor {
        return .Red
    }
    func black() -> PlayerColor {
        return .Black
    }
    
    init() {
        
        //Initialize the board with the standard checkers setup
        board = [
            [empty(),red(),empty(),red(),empty(),red(),empty(),red()],
            [red(),empty(),red(),empty(),red(),empty(),red(),empty()],
            [empty(),red(),empty(),red(),empty(),red(),empty(),red()],
            [empty(),empty(),empty(),empty(),empty(),empty(),empty(),empty()],
            [empty(),empty(),empty(),empty(),empty(),empty(),empty(),empty()],
            [black(),empty(),black(),empty(),black(),empty(),black(),empty()],
            [empty(),black(),empty(),black(),empty(),black(),empty(),black()],
            [black(),empty(),black(),empty(),black(),empty(),black(),empty()]
        ]
    }
    
    func displayBoard() {
        var outputString = ""
        for column in board {
            for piece in column {
                outputString += piece.rawValue
            }
            outputString += "\n"
        }
        outputString += "-------------------------------\n"
        println(outputString)
    }
    
    func movePieceFrom(from: (Int,Int), to: (Int,Int)) {
        let pieceToMove = board[from.1][from.0]
        board[from.1][from.0] = empty()
        board[to.1][to.0] = pieceToMove
    }
    
    func playerAtLocation(coordinates: (Int, Int)) -> PlayerColor {
        return board[coordinates.1][coordinates.0]
    }
    
    func setPlayer(player: PlayerColor, atLocation coordinates: (Int, Int)) {
        board[coordinates.1][coordinates.0] = player
    }
    
    subscript(coordinates: (Int,Int)) -> PlayerColor {
        get {
            return playerAtLocation(coordinates)
        }
        set {
            setPlayer(newValue, atLocation: coordinates)
        }
    }
    
    subscript (move coordinates: (Int,Int)) -> (Int,Int) {
        get {
            assert(false, "Using the getter of this subscript is not supported.")
        }
        set {
            movePieceFrom(coordinates, to: newValue)
        }
    }
    
}


let board = GameBoard()
board.displayBoard()

board.movePieceFrom((2,5), to: (3,4))
board.displayBoard()

let player = board[(3,4)]
println(player.description)

board[(3,4)] = .Red
board.displayBoard()

