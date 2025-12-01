import Algorithms

struct Position: Equatable {
  let column: Int
  let row: Int
}

struct Y2024Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Character]] {
    data.split(separator: "\n").map { $0.map { $0 } }
  }

  private let searchWord = "XMAS"

  // How many times does XMAS appear?
  func part1() -> Any {
    let positions = entities.enumerated().reduce(into: [Character: [Position]]()) { partialResult, value in
      for (index, character) in value.element.enumerated() {
        if searchWord.contains(character) {
          partialResult[character, default: []].append(.init(column: index, row: value.offset))
        }
      }
    }

    var xmaxCount = 0

    for xPosition in positions["X"] ?? [] {
      let i = xPosition.column
      let j = xPosition.row
      let possiblePositionsForNextChar: [Position] = [
        (i-1, j-1),
        (i, j-1),
        (i+1, j-1),
        (i-1, j),
        (i+1, j),
        (i-1, j+1),
        (i, j+1),
        (i+1, j+1)
      ].map(Position.init)

      guard let mPositions = positions["M"]?.filter({ possiblePositionsForNextChar.contains($0) }) else {
        continue
      }

      for mPosition in mPositions {
        let diff = (mPosition.column - xPosition.column, mPosition.row - xPosition.row)
        guard diff.0 <= 1 && diff.0 >= -1 && diff.1 <= 1 && diff.1 >= -1 else {
          continue
        }

        let nextColumn = diff.0 != 0 ? mPosition.column + diff.0 : mPosition.column
        let nextRow = diff.1 != 0 ? mPosition.row + diff.1 : mPosition.row

        var nextPosition = Position(column: nextColumn, row: nextRow)
        guard positions["A"]?.contains(nextPosition) == true else {
          continue
        }

        nextPosition = Position(column: nextPosition.column + diff.0, row: nextPosition.row + diff.1)
        guard positions["S"]?.contains(nextPosition) == true else {
          continue
        }
        xmaxCount += 1
      }
    }

    return xmaxCount
  }

  // How many times does an X-MAS appear?
  func part2() -> Any {
    var masCount = 0

    for row in entities.indices {
      for column in entities[row].indices {
        let char = entities[row][column]
        guard char == "A" else { continue }
        guard entities.indices.contains(row + 1) else { continue }
        guard entities.indices.contains(row - 1) else { continue }
        guard entities[row].indices.contains(column + 1) else { continue }
        guard entities[row].indices.contains(column - 1) else { continue }

        let firstDiagonalPositions = [
          (row + 1, column + 1),
          (row - 1, column - 1)
        ]

        let secondDiagonalPositions = [
          (row + 1, column - 1),
          (row - 1, column + 1)
        ]

        let firstChar = entities[firstDiagonalPositions[0].0][firstDiagonalPositions[0].1]
        let firstSecondChar = entities[firstDiagonalPositions[1].0][firstDiagonalPositions[1].1]
        let secondChar = entities[secondDiagonalPositions[0].0][secondDiagonalPositions[0].1]
        let secondSecondChar = entities[secondDiagonalPositions[1].0][secondDiagonalPositions[1].1]

        if (firstChar == "M" && firstSecondChar == "S") || (firstChar == "S" && firstSecondChar == "M") {
          if (secondChar == "S" && secondSecondChar == "M") || (secondChar == "M" && secondSecondChar == "S") {
            masCount += 1
          }
        }
      }
    }
    return masCount
  }
}
