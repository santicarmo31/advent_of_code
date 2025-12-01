import Algorithms
import Foundation

extension Y2024Day06 {
  private enum Direction {
    case up, down, left, right

    var next: Self {
      switch self {
      case .up:
        return .right
      case .right:
        return .down
      case .down:
        return .left
      case .left:
        return .up
      }
    }
  }
}

struct Y2024Day06: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // How many distinct positions will the guard visit before leaving the mapped area?
  func part1() -> Any {
    let guardCharacter: Character = "^"
    let obstructionCharacter: Character = "#"
    var startingPosition: (row: Int, column: Int) = (-1, -1)
    let entities = data.split(separator: "\n").enumerated().map { row, line in
      line.enumerated().map { column, character in
        if character == guardCharacter {
          startingPosition = (row, column)
        }
        return character
      }
    }

    var guardPosition = Direction.up
    var currentRow = startingPosition.row
    var currentColumn = startingPosition.column

    var positions = Set<String>()
    var running = true
    while running {
      var nextRow = currentRow
      var nextColumn = currentColumn
      let position = "\(currentRow),\(currentColumn)"
      positions.insert(position)

      switch guardPosition {
      case .up:
        nextRow = currentRow - 1
        if nextRow < 0 {
          running = false
        }
      case .down:
        nextRow = currentRow + 1
        if nextRow >= entities.count {
          running = false
        }
      case .left:
        nextColumn = currentColumn - 1
        if nextColumn < 0 {
          running = false
        }
      case .right:
        nextColumn = currentColumn + 1
        if nextColumn >= entities.count {
          running = false
        }
      }

      guard running else { break }

      if entities[nextRow][nextColumn] == obstructionCharacter {
        guardPosition = guardPosition.next
      } else {
        currentRow = nextRow
        currentColumn = nextColumn
      }
    }

    return positions.count
  }


  func part2() throws -> Any {
    throw PartUnimplemented(day: 6, part: 2)
    
    let guardCharacter: Character = "^"
    let obstructionCharacter: Character = "#"
    var startingPosition: (row: Int, column: Int) = (-1, -1)
    let entities = data.split(separator: "\n").enumerated().map { row, line in
      line.enumerated().map { column, character in
        if character == guardCharacter {
          startingPosition = (row, column)
        }
        return character
      }
    }

    var result: Set<String> = []

    for i in 0..<entities.count * entities.count {
      let row = i / entities.count
      let column = i % entities.count
      guard entities[row][column] != obstructionCharacter else {
        continue
      }

      var newMatrix = entities
      newMatrix[row][column] = "L"
      if let value = tryLoop(startingRow: startingPosition.row, startingColumn: startingPosition.column, direction: .up, matrix: newMatrix) {
        result.insert(value)
      }
    }

    return result.count
  }

  private func tryLoop(startingRow: Int, startingColumn: Int, direction: Direction, matrix: [[Character]]) -> String? {
    let obstructionCharacter: Character = "#"
    var currentRow = startingRow
    var currentColumn = startingColumn
    var guardPosition = direction
    var foundDirection: Direction?
    var found: Int = 0
    while true {
      var nextRow = currentRow
      var nextColumn = currentColumn

      switch guardPosition {
      case .up:
        nextRow = currentRow - 1
        if nextRow < 0 {
          return nil
        }
      case .down:
        nextRow = currentRow + 1
        if nextRow >= matrix.count {
          return nil
        }
      case .left:
        nextColumn = currentColumn - 1
        if nextColumn < 0 {
          return nil
        }
      case .right:
        nextColumn = currentColumn + 1
        if nextColumn >= matrix.count {
          return nil
        }
      }

      if matrix[nextRow][nextColumn] == obstructionCharacter || matrix[nextRow][nextColumn] == "L" {
        if matrix[nextRow][nextColumn] == "L" {
          foundDirection = direction
          found += 1
        }
        guardPosition = guardPosition.next
      } else {
        currentRow = nextRow
        currentColumn = nextColumn
      }

      if found > 2 {
        return "\(nextRow),\(nextColumn)"
      }
    }
  }
}
