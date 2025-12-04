import Foundation
import Algorithms

struct Y2025Day04: AdventDay {
  let rollOfPaper: Character = "@"
  var data: String

  var entities: [[Character]] {
    data
      .split(separator: "\n")
      .map { Array($0) } // no need to replace "\n" inside each line
  }

  let directions8 = [
    (-1, -1), // top-left
    (-1,  0), // top
    (-1,  1), // top-right
    ( 0, -1), // left
    ( 0,  1), // right
    ( 1, -1), // bottom-left
    ( 1,  0), // bottom
    ( 1,  1)  // bottom-right
  ]

  func part1() -> Int {
    let grid = entities
    let rowCount = grid.count
    let colCount = grid[0].count

    var count = 0

    for row in 0..<rowCount {
      for column in 0..<colCount {
        // Only consider cells that are rolls of paper
        guard grid[row][column] == rollOfPaper else { continue }

        let neighborRolls = countAdjacentRolls(
          in: grid,
          row: row,
          column: column,
          earlyStop: 4
        )

        // If fewer than 4 neighbors are rolls of paper, count this one
        if neighborRolls < 4 {
          count += 1
        }
      }
    }

    return count
  }

  func part2() -> Int {
    var grid = entities
    let rowCount = grid.count
    let colCount = grid[0].count

    var totalRemoved = 0
    var indexesToReplace: [(Int, Int)] = []

    repeat {
      indexesToReplace = []
      for row in 0..<rowCount {
        for column in 0..<colCount {
          guard grid[row][column] == rollOfPaper else { continue }

          let neighborRolls = countAdjacentRolls(
            in: grid,
            row: row,
            column: column,
            earlyStop: 4
          )

          if neighborRolls < 4 {
            indexesToReplace.append((row, column))
          }
        }
      }

      // Replace all that qualified in this iteration
      for (row, column) in indexesToReplace {
        grid[row][column] = "."
      }

      totalRemoved += indexesToReplace.count

      // Continue until no more cells qualify
    } while !indexesToReplace.isEmpty

    return totalRemoved
  }

  /// A helper that checks if there is at least one roll with < 4 neighbors.
  /// You could also just check `indexesToReplace.isEmpty` in the loop and break.
  private func gridContainsRemovableRoll(grid: [[Character]]) -> Bool {
    let rowCount = grid.count
    let colCount = grid[0].count

    for row in 0..<rowCount {
      for column in 0..<colCount {
        guard grid[row][column] == rollOfPaper else { continue }

        let neighborRolls = countAdjacentRolls(
          in: grid,
          row: row,
          column: column,
          earlyStop: 4
        )

        if neighborRolls < 4 {
          return true
        }
      }
    }

    return false
  }

  /// Counts how many adjacent cells (in 8 directions) contain a roll of paper.
  /// Stops early if the count reaches `earlyStop`, to avoid extra work.
  private func countAdjacentRolls(
    in grid: [[Character]],
    row: Int,
    column: Int,
    earlyStop: Int? = nil
  ) -> Int {
    let rowCount = grid.count
    let colCount = grid[0].count

    var neighborRolls = 0

    for (dr, dc) in directions8 {
      let newRow = row + dr
      let newCol = column + dc

      // Skip if it's outside the grid
      guard newRow >= 0, newRow < rowCount,
            newCol >= 0, newCol < colCount else { continue }

      if grid[newRow][newCol] == rollOfPaper {
        neighborRolls += 1

        // If we hit the early-stop threshold, return immediately
        if let earlyStop, neighborRolls >= earlyStop {
          return neighborRolls
        }
      }
    }

    return neighborRolls
  }

}
