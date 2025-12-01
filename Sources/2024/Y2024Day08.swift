import Algorithms
import Foundation

struct Y2024Day08: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // How many unique locations within the bounds of the map contain an antinode?
  func part1() -> Any {
    var positions: [Character: [Position]] = [:]
    let matrix = data.split(separator: "\n").enumerated().map { row, line in
      line.enumerated().map { column, character in
        guard character != "." else {
          return character
        }
        positions[character, default: []].append(.init(row: row, column: column))
        return character
      }
    }

    var antinodesPositions: Set<Position> = []
    for (_, values) in positions {
      for value in values.combinations(ofCount: 2) {
        let (a, b) = (value[0], value[1])
        let rowDifference = a.row - b.row
        let columnDifference = a.column - b.column

        let antinode1 = Position(row: a.row + rowDifference, column: a.column + columnDifference)
        let antinode2 = Position(row: b.row - rowDifference, column: b.column - columnDifference)

        if antinode1.row >= 0, antinode1.row < matrix.count, antinode1.column < matrix.count, antinode1.column >= 0 {
          antinodesPositions.insert(antinode1)
        }

        if antinode2.row >= 0, antinode2.row < matrix.count, antinode2.column < matrix.count, antinode2.column >= 0 {
          antinodesPositions.insert(antinode2)
        }
      }
    }
    return antinodesPositions.count
  }


  func part2() -> Any {
    var positions: [Character: [Position]] = [:]
    let matrix = data.split(separator: "\n").enumerated().map { row, line in
      line.enumerated().map { column, character in
        guard character != "." else {
          return character
        }
        positions[character, default: []].append(.init(row: row, column: column))
        return character
      }
    }

    var antinodesPositions: Set<Position> = []
    for (_, values) in positions {
      for value in values.combinations(ofCount: 2) {
        let (a, b) = (value[0], value[1])
        let rowDifference = a.row - b.row
        let columnDifference = a.column - b.column

        var antinode = a
        while antinode.row >= 0, antinode.row < matrix.count, antinode.column < matrix.count, antinode.column >= 0  {
          antinodesPositions.insert(antinode)
          antinode = .init(row: antinode.row + rowDifference, column: antinode.column + columnDifference)
        }

        antinode = b
        while antinode.row >= 0, antinode.row < matrix.count, antinode.column < matrix.count, antinode.column >= 0  {
          antinodesPositions.insert(antinode)
          antinode = .init(row: antinode.row - rowDifference, column: antinode.column - columnDifference)
        }
      }
    }
    
    return antinodesPositions.count
  }
}

extension Y2024Day08 {
  private struct Position: Comparable, Hashable, CustomStringConvertible {
    let row, column: Int

    static func < (lhs: Y2024Day08.Position, rhs: Y2024Day08.Position) -> Bool {
      return lhs.row < rhs.row || (lhs.row == rhs.row && lhs.column < rhs.column)
    }

    var description: String {
      return "(\(row), \(column))"
    }
  }
}
