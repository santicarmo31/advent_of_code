import Foundation
import Algorithms

struct Y2025Day07: AdventDay {
  var data: String

  var entities: [[Character]] {
    data
      .split(whereSeparator: \.isNewline).map { Array($0) }
  }

  private let initialStream: Character = "S"
  private let beam: Character = "|"
  private let splitter: Character = "^"
  private let emptySpace: Character = "."

  func part1() -> Int {
    var beamSplits = 0
    var entities = entities
    outLoop: for row in 0..<entities.count {
      for column in 0..<entities[row].count {
        let character = entities[row][column]
        let nextRow = row + 1
        guard nextRow < entities.count else { break outLoop }
        let nextRowCharacter = entities[nextRow][column]
        switch (character, nextRowCharacter) {
        case (initialStream, emptySpace):
          entities[nextRow][column] = beam
        case (beam, splitter):
          if column - 1 >= 0 {
            entities[nextRow][column - 1] = beam
          }
          if column + 1 < entities[row].count {
            entities[nextRow][column + 1] = beam
          }
          beamSplits += 1
        case (beam, emptySpace):
          entities[nextRow][column] = beam
        default:
          continue
        }
      }
    }

    return beamSplits
  }

  struct Point: Hashable {
    let r: Int
    let c: Int
  }

  func part2() -> Int {
    let grid = entities
    let totalRowCount = grid.count
    let totalColumnCount = grid[0].count

    // Memoization cache: each grid coordinate stores the total number
    // of timelines that originate from that position.
    var memoizedTimelineCounts = [Point: Int]()

    /// Computes the number of timelines that originate from a specific grid position.
    ///
    /// Rules:
    /// - Leaving the grid (down or sideways) counts as **one completed timeline**.
    /// - A '^' splitter creates **two** timelines:
    ///       • one moving to the left (same row, column - 1)
    ///       • one moving to the right (same row, column + 1)
    /// - Any other character simply moves the particle **downward** by one row.
    ///
    /// Results are memoized so each position is solved only once.
    func countTimelines(startingAtRow rowIndex: Int,
                        column columnIndex: Int) -> Int {

      // Case 1: The particle moves outside of the grid.
      // This represents one completed timeline.
      let isBelowGrid = rowIndex >= totalRowCount
      let isLeftOfGrid = columnIndex < 0
      let isRightOfGrid = columnIndex >= totalColumnCount

      if isBelowGrid || isLeftOfGrid || isRightOfGrid {
        return 1
      }

      // Case 2: Memoized result exists — reuse it.
      let position = Point(r: rowIndex, c: columnIndex)
      if let cachedTimelineCount = memoizedTimelineCounts[position] {
        return cachedTimelineCount
      }

      let cellCharacter = grid[rowIndex][columnIndex]
      let totalTimelinesFromHere: Int

      // Case 3: Splitter '^' → recursively count left + right.
      if cellCharacter == "^" {
        let timelinesFromLeft = countTimelines(
          startingAtRow: rowIndex,
          column: columnIndex - 1
        )
        let timelinesFromRight = countTimelines(
          startingAtRow: rowIndex,
          column: columnIndex + 1
        )
        totalTimelinesFromHere = timelinesFromLeft + timelinesFromRight
      } else {
        // Case 4: Any non-splitter character → continue downward.
        totalTimelinesFromHere = countTimelines(
          startingAtRow: rowIndex + 1,
          column: columnIndex
        )
      }

      // Store result in memoization cache.
      memoizedTimelineCounts[position] = totalTimelinesFromHere
      return totalTimelinesFromHere
    }

    // Locate the starting position 'S' in the grid.
    var startRowIndex = 0
    var startColumnIndex = 0

    searchLoop: for rowIndex in 0..<totalRowCount {
      for columnIndex in 0..<totalColumnCount {
        if grid[rowIndex][columnIndex] == "S" {
          startRowIndex = rowIndex
          startColumnIndex = columnIndex
          break searchLoop
        }
      }
    }

    // Begin counting timelines starting exactly at the 'S' position.
    return countTimelines(startingAtRow: startRowIndex,
                          column: startColumnIndex)
  }
}
