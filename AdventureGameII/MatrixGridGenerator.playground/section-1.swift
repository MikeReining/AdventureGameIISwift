// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript (row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}


var grid16 = Matrix(rows: 4, columns: 4)

grid16.grid[0] = 0.0

for item in grid16.grid {
    var initialValue: Double = 0.0
    var initItemValue = item
    var newItemValue = initialValue + item
    item = newItemValue
        initialValue += 0.1
}


