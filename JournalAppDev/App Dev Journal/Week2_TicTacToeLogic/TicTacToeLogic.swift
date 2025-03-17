import Foundation

// Enum to represent players
enum Player: String {
    case X = "X"
    case O = "O"
}

// represents the Tic-Tac-Toe board
class Board {
    private var grid: [[String]]
    
    init() {
        self.grid = Array(repeating: Array(repeating: "-", count: 3), count: 3)
    }
    
    // Display the board
    func display() {
        for row in grid {
            print(row.joined(separator: " | "))
        }
        print("\n")
    }
    
    // Place a move
    func makeMove(row: Int, col: Int, player: Player) -> Bool {
        if grid[row][col] == "-" {
            grid[row][col] = player.rawValue
            return true
        }
        return false
    }
    
    // Check for a winner
    func checkWinner() -> Player? {
        let players: [Player] = [.X, .O]
        
        for player in players {
            let symbol = player.rawValue
            
            // Check rows & columns
            for i in 0..<3 {
                if grid[i][0] == symbol && grid[i][1] == symbol && grid[i][2] == symbol { return player }
                if grid[0][i] == symbol && grid[1][i] == symbol && grid[2][i] == symbol { return player }
            }
            
            // Check diagonals
            if grid[0][0] == symbol && grid[1][1] == symbol && grid[2][2] == symbol { return player }
            if grid[0][2] == symbol && grid[1][1] == symbol && grid[2][0] == symbol { return player }
        }
        
        return nil
    }
    
    // Check if board is full
    func isFull() -> Bool {
        return !grid.joined().contains("-")
    }
}

// Class to handle game logic
class TicTacToeGame {
    private var board = Board()
    private var currentPlayer: Player = .X
    
    func play() {
        while true {
            board.display()
            print("\(currentPlayer.rawValue)'s turn. Enter row and column (0-2):")
            
            if let input = readLine(), let row = Int(input.split(separator: " ")[0]), let col = Int(input.split(separator: " ")[1]) {
                if board.makeMove(row: row, col: col, player: currentPlayer) {
                    if let winner = board.checkWinner() {
                        board.display()
                        print("\(winner.rawValue) wins!")
                        return
                    }
                    
                    if board.isFull() {
                        board.display()
                        print("It's a draw!")
                        return
                    }
                    
                    currentPlayer = (currentPlayer == .X) ? .O : .X
                } else {
                    print("Invalid move. Try again.")
                }
            }
        }
    }
}

// Run the game
let game = TicTacToeGame()
game.play()
